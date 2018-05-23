module InstanceCounter
  def self.included(base_class)
    base_class.extend ClassMethods
    base_class.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :instances_counter
  end

  module InstanceMethods
    private

    def instances_counter_up
      self.class.instances_counter ||= 0
      self.class.instances_counter += 1
    end
  end
end
