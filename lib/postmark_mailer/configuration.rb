module PostmarkMailer
  class Configuration
    attr_accessor :api_key, :default_delivery_queue

    def initialize
      @api_key = nil
      @default_delivery_queue = :default
    end
  end
end
