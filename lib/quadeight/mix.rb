class Mix
  attr_reader :user

  def initialize json_obj
    user_pop_proc = Proc.new do |obj, key, value|
      if key == 'user_id'
        obj.send( :populate_user, value )
      end
      key == 'user_id'
    end
    Helpers.populate_instance_variables self, json_obj, user_pop_proc
  end

  def populate_user id
    @user = User.new id
  end
end
