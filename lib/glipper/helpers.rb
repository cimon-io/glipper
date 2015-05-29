module Glipper
  module Helpers
    def helpers
      @helpers
    end
    alias_method :h, :helpers

    def method_missing(name, *args, &block)
      if h.respond_to?(name)
        h.public_send(name, *args, &block)
      else
        super
      end
    end
  end
end
