module Validation
  def self.included(base_class)
    base_class.extend ClassMethods
    base_class.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(name, *args)
      validations_var_name = '@validations'
      validations = instance_variable_get validations_var_name
      validations ||= []
      validations << {
        name: "@#{name}",
        validation_type: args.first,
        parameters: args[1]
      }
      instance_variable_set validations_var_name, validations
    end
  end

  module InstanceMethods
    def validate!
      self.class.instance_variable_get('@validations').each do |validation|
        send("validate_#{validation[:validation_type]}", validation[:name], validation[:parameters])
      end
      true
    end

    def valid?
      validate!
    rescue StandardError
      false
    end

    protected

    def validate_presence(name, *_args)
      val_name = instance_variable_get name.to_s
      raise "#{name} не может быть пустым" if val_name.nil? || val_name == ''
    end

    def validate_type(name, type, *_args)
      val_name = instance_variable_get name.to_s
      raise "неверный тип #{name}" unless val_name.is_a? type
    end

    def validate_format(name, format,  *_args)
      val_name = instance_variable_get name.to_s
      raise "#{name} не соответствует формату" unless val_name =~ format
    end
  end
end
