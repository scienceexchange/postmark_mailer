module PostmarkMailer
  class Base
    attr_accessor :action_name

    class << self
      private

      def respond_to_missing?(method, *)
        new.respond_to?(method) || super
      end

      def method_missing(method, *args)
        if respond_to_missing?(method)
          new(method.to_s).public_send(method, *args)
        else
          super
        end
      end
    end

    private

    def initialize(method_name = nil)
      @action_name = method_name
    end

    def mail(options)
      if prevent_delivery?
        NullDelivery.new(options)
      else
        MessageDelivery.new(options)
      end
    end

    def prevent_delivery?; end
  end
end
