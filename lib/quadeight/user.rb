class User
  def initialize id
    json_obj = EightGetter.get_json "users/#{id}"
    Helpers.populate_instance_variables self, json_obj["user"]
  end

  def mixes
    json_obj = EightGetter.get_json "users/#{id}/mixes"
    MixSet.new json_obj['mix_set']
  end
end
