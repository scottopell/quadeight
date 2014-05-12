class Client
  def initialize options
    api_key = options[:api_key]
    EightGetter.api_key = api_key
  end

  def get_mixes
    raw_json = EightGetter.get 'mixes'
    mixes_obj = JSON.parse raw_json
    mixes = []
    mixes_obj["mixes"].each do |mix|
      mixes << Mix.new(mix)
    end
    mixes
  end
end
