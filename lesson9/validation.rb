# frozen_string_literal: true

# Validation
module Validation
  def self.included(klass)
    klass.include InstanceMethods
    klass.extend ClassMethods
  end

  # instance methods
  module InstanceMethods
    def validate!
      methods.select { |m| m.to_s =~ /validate_/ }.each do |method|
        send(method.to_sym)
      end
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    def validate_presence
      params = self.class.validations.select { |i| i[:validation_type] == :presence }
      params.each do |param|
        attr = instance_variable_get("@#{param[:attr_name]}".to_sym)
        raise 'Значение не может быть пустым!' if attr.nil? || (attr.is_a?(String) && attr.empty?)
      end
    end

    def validate_format
      params = self.class.validations.select { |i| i[:validation_type] == :format }
      params.each do |param|
        attr = instance_variable_get("@#{param[:attr_name]}".to_sym)
        raise 'Значение не соответствует формату!' unless attr =~ param[:args][0]
      end
    end

    def validate_type
      params = self.class.validations.select { |i| i[:validation_type] == :type }
      params.each do |param|
        attr = instance_variable_get("@#{param[:attr_name]}".to_sym)
        raise ' Тип значения не соответствует заданному классу!' unless attr.is_a?(param[:args][0])
      end
    end
  end

  # class methods
  module ClassMethods
    def validate(name, type, *args)
      @validations ||= []
      @validations << { attr_name: name, validation_type: type, args: args }
    end

    def validations
      @validations
    end
  end
end
