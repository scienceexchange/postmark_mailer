require "active_job"

module PostmarkMailer
  class DeliveryJob < ActiveJob::Base
    queue_as { ActionMailer::Base.deliver_later_queue_name }

    def perform(options)
      PostmarkMailer::MessageDelivery.new(options).deliver_now
    end
  end
end
