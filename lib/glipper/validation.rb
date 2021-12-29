module Glipper
  module Validation
    extend ActiveSupport::Concern

    # module ApplicationHelper
    #   def glip(resource)
    #     glipper_class.decorate(resource, self)
    #   end
    #
    #   def glipper_class
    #     ::Sample::ApplicationGlipper
    #   end
    #
    #   def method_missing(name, *args, instead_nil: '', **params, &block)
    #     return super(name, *args, **params, &block) unless glipper_class.glip_method?(name, *args, **params, &block)
    #     return instead_nil.html_safe if glipper_class.glip_skip?(name, *args, **params, &block)
    #     return super(name, *args, **params, &block) unless glipper_class.glip_arguments?(name, *args, **params, &block)
    #
    #     glip(args.first).public_send(glipper_class.glip_method_name(name), *args[1..-1], **params, &block)
    #   end
    #
    #   def respond_to_missing?(name, include_private = false)
    #     glipper_class.glip_method?(name)
    #   end
    # end

    module ClassMethods
      def glip_arguments?(name, *args, &block)
        name.starts_with?('glip_')
      end

      def glip_method?(name, *args, &block)
        name.starts_with?('glip_')
      end

      def glip_arguments?(name, *args, &block)
        root_classes.any? { |k| args&.first.is_a?(k) }
      end

      def glip_skip?(name, *args, &block)
        name.starts_with?('glip_') && name.ends_with?('!') && args.first.nil?
      end

      def glip_method_name(name)
        name.to_s.gsub(/!\z/, '').to_sym
      end
    end
  end
end
