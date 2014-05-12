class Mix

  def initialize json_obj
    json_obj.keys.each do |key|
      instance_var_name = "@#{key}".to_sym
      # create getter and setter for variable
      class <<self
        self
      end.class_eval do
        attr_accessor key.to_sym
      end
      instance_variable_set instance_var_name, json_obj[key]
      puts "key is #{key} and value is #{json_obj[key]}"
    end
  end
end
