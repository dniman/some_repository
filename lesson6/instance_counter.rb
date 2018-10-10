module InstanceCounter
  
  def self.included(base)
    base.instance_eval do
      include InstanceMethods
      
      @@instances = 0
      def self.instances
        @@instances
      end
      def self.instances=(val)
        @@instances = val
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
