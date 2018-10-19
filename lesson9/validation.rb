# frozen_string_literal: true

# Validation
module Validation
  def self.included(klass)
    klass.extend ClassMethods
  end

  # class methods
  module ClassMethods
    def validate(name, val_type, value = nil)
      define_validate!(name, val_type, value)
      define_valid?
    end

    private

    def define_validate!(name, val_type, value)
      define_method(:validate!) do
        @_validations ||= [] unless instance_variable_get(:@_validations)
        attr = instance_variable_get("@#{name}".to_sym)

        if val_type == :presence
          @_validations << lambda do
            raise 'Значение не может быть пустым!' if attr.nil? || attr.empty?
          end
        end

        if val_type == :format
          @_validations << lambda do
            raise 'Значение не соответствует формату!' unless attr =~ value
          end
        end

        if val_type == :type
          @_validations << lambda do
            raise ' Тип значения не соответствует заданному классу!' unless attr.is_a?(value)
          end
        end

        @_validations.each(&:call)
      end
    end

    def define_valid?
      define_method(:valid?) do
        begin
          send(:validate!)
          true
        rescue StandardError
          false
        end
      end
    end
  end
end
