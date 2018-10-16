# frozen_string_literal: true

#
# Module InstanceCounter
#
module InstanceCounter
  def self.included(base)
    base.instance_eval do
      extend ClassMethods
    end
  end

  private

  def register_instance
    self.class.instances += 1
  end

  module ClassMethods
    @@instances = 0

    def instances
      @@instances
    end

    def instances=(val)
      @@instances = val
    end
  end
end
