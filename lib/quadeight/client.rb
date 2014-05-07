class Client
  def initialize options
    api_key = options[:api_key]
    EightGetter.api_key = api_key
  end

  def get_mixes
    EightGetter.get 'mixes'
  end
end
