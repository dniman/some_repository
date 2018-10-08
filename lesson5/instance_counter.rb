module InstanceCounter
  
  def self.included(base)
    base.instance_eval do
      include InstanceMethods
      
      @instances = 0
      class << self
        attr_accessor :instances
      end
    end
  end

  module InstanceMethods
    private
    def register_instance
      self.class.instances += 1
    end
  end
end
