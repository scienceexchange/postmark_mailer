module PostmarkMailer
  class Base
    class << self
      private

      def respond_to_missing?(method, *)
        self.new.respond_to?(method) || super
      end

      def method_missing(method, *args)
        if respond_to_missing?(method)
          self.new.public_send(method, *args)
        else
          super
        end
      end
    end

    private

      def mail(options)
        options[:to] = Rails.env.production? ? options[:to] : 'staging@scienceexchange.com'
        options[:from] = Mailer::NOTIFICATIONS
        PostmarkMailer::MessageDelivery.new(options)
      end
  end
end
