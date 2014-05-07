class Client
  def initialize options
    api_key = options[:api_key]
    @network_handler = EightGetter.new api_key
  end

  def get_mixes
    @network_handler.get 'mixes'
  end
end
