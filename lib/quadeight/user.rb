class User
  def initialize id
    raw_json = EightGetter.get "users/#{id}"
    json_obj = JSON.parse raw_json
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
    raw_json = EightGetter.get "users/#{id}/mixes"
    json_obj = JSON.parse raw_json
    json_mixes = json_obj['mixes']
    mixes = []
    json_mixes.each do |jm|
      mixes << Mix.new(jm)
    end
    mixes
  end
end
