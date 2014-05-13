class User
  def initialize id
    json_obj = EightGetter.get_json "users/#{id}"
    user = json_obj["user"]

    user.keys.each do |key|
      instance_var_name = "@#{key}".to_sym
      # create getter and setter for variable
      class <<self
        self
      end.class_eval do
        attr_accessor key.to_sym
      end
      instance_variable_set instance_var_name, user[key]
    end
  end

  def mixes
    json_obj = EightGetter.get_json "users/#{id}/mixes"
    json_mixes = json_obj['mix_set']['mixes']
    mixes = []
    json_mixes.each do |jm|
      mixes << Mix.new(jm)
    end
    mixes
  end
end
