require "active_job"

module PostmarkMailer
  class DeliveryJob < ActiveJob::Base
    queue_as { PostmarkMailer.configuration.default_delivery_queue }

    def perform(options)
      MessageDelivery.new(options).deliver_now
    end
  end
end
