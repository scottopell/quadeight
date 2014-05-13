class Track
  def initialize json_obj
    Helpers.populate_instance_variables self, json_obj
  end
end
