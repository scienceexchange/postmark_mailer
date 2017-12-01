module PostmarkMailer
  class MessageDelivery
    attr_accessor :client, :options

    def initialize(opts)
      @client = Postmark::ApiClient.new(PostmarkMailer.configuration.api_key)
      @options = opts
    end

    def deliver_now
      client.deliver_with_template(options)
    end

    def deliver_later
      DeliveryJob.perform_later(options)
    end
  end
end
