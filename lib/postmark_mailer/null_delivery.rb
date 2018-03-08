require 'postmark_mailer'
# Null object for MessageDelivery. Follows the same interface but performs no
# deliveries.
module PostmarkMailer
  class NullDelivery < MessageDelivery
    # Does nothing
    # @return [nil]
    def deliver_now; end

    # Does nothing
    # @return [nil]
    def deliver_later; end
  end
end
