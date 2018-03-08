require 'spec_helper'
require 'postmark_mailer/null_delivery'

module PostmarkMailer
  RSpec.describe NullDelivery do
    subject { NullDelivery.new({}) }

    specify :deliver_now do
      expect(subject.deliver_now).to be_nil
    end

    specify :deliver_later do
      expect(subject.deliver_later).to be_nil
    end
  end
end
