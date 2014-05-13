class Client
  def initialize options
    api_key = options[:api_key]
    EightGetter.api_key = api_key
  end

  def get_mixes
    mixset_obj = EightGetter.get_json('mix_sets/all', { include: 'mixes'})
    MixSet.new mixset_obj["mix_set"]
  end
end
