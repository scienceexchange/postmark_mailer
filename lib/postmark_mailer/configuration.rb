module PostmarkMailer
  class Configuration
    attr_accessor :api_key, :delivery_queue

    def initialize
      @api_key = nil
      @delivery_queue = :default
    end
  end
end
