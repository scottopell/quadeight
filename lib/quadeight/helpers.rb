module Helpers
  require 'net/http'

  # this is for custom partial read below
  # provide access to the actual socket
  class Net::HTTPResponse
    attr_reader :socket
  end

  def self.populate_instance_variables obj, hash, procc = nil
    hash.keys.each do |key|
      if procc.class == Proc
        if procc.call(obj, key, hash[key])
          next
        end
      end
      instance_var_name = "@#{key}".to_sym
      # create getter and setter for variable
      class << obj
        self
      end.class_eval do
        attr_accessor key.to_sym
      end
      obj.send(:instance_variable_set, instance_var_name, hash[key])
    end
  end

  def self.partial_read n, track_url, depth = 0
    if depth > 10
      return nil
    end
    new_url = track_url.sub(/https:/, "http:")
    response = EightGetter.head track_url
    #response.headers.each { |key, value| puts "#{key} => #{value}" }

    #puts response
    if response.code == "301" || response.code == "302"
      partial_read n, response.header['location'], depth + 1
    elsif response.headers['Accept-Ranges'] == 'bytes'
      return range_partial_read n, new_url
    elsif response.code == "200"
      custom_partial_read n, track_url
    else
      puts "not an expected response"
      puts response.code
    end
  end

  private

  def self.range_partial_read n, track_url
    bytes = nil
    uri = URI(track_url)
    request = Net::HTTP::Get.new(uri.request_uri)
    request.add_field 'Range', "bytes=0-#{n}"
    Net::HTTP.start(uri.host, uri.port) do |http|
      response = http.request(request)
      bytes = response.body
    end
    bytes
  end

  def self.custom_partial_read n, track_url
    new_url = track_url.sub(/https:/, "http:")
    uri = URI(new_url)
    bytes = nil
    begin
      Net::HTTP.start(uri.host, uri.port) do |http|
        http.set_debug_output $stderr
        request = Net::HTTP::Get.new(uri.request_uri)
        # calling request with a block prevents body from being read
        http.request(request) do |response|
          if response.code == "301" || response.code == "302"
            http.finish
            custom_partial_read n, response.header['location']
          end
          # do whatever limited reading you want to do with the socket
          if response.header.content_length < n
            n = response.header.content_length
          end
          bytes = response.socket.read n
          # be sure to call finish before exiting the block
          http.finish
        end
      end
    rescue IOError => e
      puts e.class
      puts e.to_s
      # ignore
    end
    bytes
  end
end
