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
  end

  # class methods
  module ClassMethods
    def validate(name, val_type, value = nil)
      if val_type == :presence
        define_method(:validate_presence) do
          attr = instance_variable_get("@#{name}".to_sym)
          raise 'Значение не может быть пустым!' if attr.nil? || (attr.is_a?(String) && attr.empty?)
        end
      end

      if val_type == :format
        define_method(:validate_format) do
          attr = instance_variable_get("@#{name}".to_sym)
          raise 'Значение не соответствует формату!' unless attr =~ value
        end
      end

      if val_type == :type
        define_method(:validate_type) do
          attr = instance_variable_get("@#{name}".to_sym)
          raise ' Тип значения не соответствует заданному классу!' unless attr.is_a?(value)
        end
      end
    end
  end
end
