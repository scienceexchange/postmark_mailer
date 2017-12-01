module PostmarkMailer
  class MessageDelivery
    attr_accessor :client, :options

    def initialize(opts)
      @client = Postmark::ApiClient.new(API_KEYS['postmarkapp'][Rails.env])
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
