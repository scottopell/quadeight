module Helpers
  def self.populate_instance_variables obj, hash, procc = nil
    hash.keys.each do |key|
      if procc.class == Proc
        if procc.call(obj, key, hash[key])
          next
        end
      end
      instance_var_name = "@#{key}".to_sym
      # create getter and setter for variable
      class << obj
        self
      end.class_eval do
        attr_accessor key.to_sym
      end
      obj.send(:instance_variable_set, instance_var_name, hash[key])
    end
  end
end
