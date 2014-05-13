class Client
  def initialize options
    api_key = options[:api_key]
    EightGetter.api_key = api_key
  end

  def get_mixes
    mixes_obj = EightGetter.get_json('mix_sets/all', { include: 'mixes'})
    mixes = []
    mixes_obj["mix_set"]["mixes"].each do |mix|
      mixes << Mix.new(mix)
    end
    mixes
  end
end
