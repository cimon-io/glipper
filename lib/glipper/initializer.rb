module Glipper
  module Initializer
    extend ActiveSupport::Concern

    included do
      attr_reader :helpers
      attr_reader :object
      attr_reader :object_classes
      alias_method :o, :object
      alias_method :resource, :object
    end

    module ClassMethods
      def decorate(resource, helpers=ActionController::Base.helpers)
        drapper = self.find_drapper_for(resource)

        raise ::Glipper::NoDrapperFoundError.new("Could not find drapper for #{resource}") if drapper.nil?

        drapper.new(resource, helpers)
      end
    end

    def initialize(object, helpers=ActionController::Base.helpers)
      raise "#{object} is not instance of #{@object_classes.join(', ')}" unless self.class.object_classes.find { |object_class| object.is_a?(object_class) }
      @helpers = helpers
      @object = object
    end

    def decorate(another_resource)
      self.class.decorate(another_resource)
    end

  end
end
