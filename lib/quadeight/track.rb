class Track
  require 'mp4info'
  attr_accessor :length

  # mp4 info requires an io object, and calls stat.size on it
  # I have the beginning bytes, that's it
  # That's all I'm trying to emulate here
  class MyStringIO < StringIO
    Stat = Struct.new :size
    def stat
      stat = Stat.new size
      return stat
    end
  end

  def initialize json_obj
    Helpers.populate_instance_variables self, json_obj
  end

  def length
    @length || populate_length
  end

  private

  def populate_length
    response = EightGetter.head track_file_stream_url
    #response.headers.each { |key, value| puts "#{key} => #{value}" }
    if response.headers.has_key? 'x-amz-meta-duration'
      @length = response.headers['x-amz-meta-duration'].to_i
    else
      # the following will get the actual uri, after redirects
      uri = response.request.last_uri
      file_type = uri.path[-3..-1].downcase
      if file_type == "mp3"
        bytes = Helpers.partial_read 30, track_file_stream_url
        @length = 240
      elsif file_type == "m4a"
        bytes = Helpers.partial_read 1900, track_file_stream_url
        #bytes[0..40].each_byte { |b| puts "#{b.chr}|#{b}" }
        io = MyStringIO.new
        io.write bytes
        io.rewind
        info = MP4Info.new io
        # I think some m4as are malformed, they don't parse correctly...
        if !info.secs.nil?
          @length = info.secs.to_i * 1000
        else
          @length = 240 * 1000
        end
      end
    end
    @length
  end
end
