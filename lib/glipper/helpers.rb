module Glipper
  module Helpers
    def helpers
      @helpers
    end
    alias_method :h, :helpers

    def method_missing(name, *args, **options, &block)
      if h.respond_to?(name)
        h.public_send(name, *args, **options, &block)
      else
        super
      end
    end

    def respond_to_missing?(name, include_private = false)
      h.respond_to?(name) || super
    end
  end
end
