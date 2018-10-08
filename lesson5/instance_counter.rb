module InstanceCounter
  
  def self.included(base)
    base.instance_eval do
      @instances = 0
      class << self
        attr_accessor :instances
      end
    end
    base.class_eval do
      private
      def register_instance
        self.class.instances += 1
      end
    end
  end
end
