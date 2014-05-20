class Track
  require 'mp4info'
  require 'mp3info'
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

  def export_track location
    mp3_path = "#{location}/#{@name} -#{@year}.mp3"
    if file_type == 'm4a'
      begin
        tmp_dir = Dir.mktmpdir
        m4a_path = "#{tmp_dir}/tmp.m4a"
        wav_path = "#{tmp_dir}/tmp.wav"
        EightGetter.download_to track_file_stream_url, m4a_path
        `faad #{m4a_path} -o #{wav_path}`
        `lame #{wav_path} -o #{mp3_path}`
      ensure
        FileUtils.remove_entry tmp_dir
      end
    elsif file_type == 'mp3'
      EightGetter.download_to track_file_stream_url, mp3_path
    end
    write_tags mp3_path
    return mp3_path
  end

  private

  def write_tags mp3_path
    Mp3Info.open(mp3_path) do |mp3|
      mp3.tag.artist = performer
      mp3.tag.title = name
      mp3.tag.album = release_name
      mp3.tag.year = year
    end
  end

  def file_type
    @file_type || populate_file_type
  end

  def populate_file_type
    response = EightGetter.head track_file_stream_url
    uri = response.request.last_uri
    @file_type = uri.path[-3..-1].downcase
  end

  def populate_length
    response = EightGetter.head track_file_stream_url
    #response.headers.each { |key, value| puts "#{key} => #{value}" }
    if response.headers.has_key? 'x-amz-meta-duration'
      @length = response.headers['x-amz-meta-duration'].to_i
    else
      # the following will get the actual uri, after redirects
      uri = response.request.last_uri
      @file_type = uri.path[-3..-1].downcase
      if file_type == "mp3"
        bytes = Helpers.partial_read 30, track_file_stream_url
        @length = 240 * 1000 #TODO
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
