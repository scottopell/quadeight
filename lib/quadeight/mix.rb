class Mix
  attr_reader :user

  def initialize json_obj
    json_obj.keys.each do |key|
      if key == 'user_id'
        populate_user json_obj['user_id']
        next
      end
      instance_var_name = "@#{key}".to_sym
      # create getter and setter for variable
      class <<self
        self
      end.class_eval do
        attr_accessor key.to_sym
      end
      instance_variable_set instance_var_name, json_obj[key]
    end
  end

  def populate_user id
    @user = User.new id
  end
end
