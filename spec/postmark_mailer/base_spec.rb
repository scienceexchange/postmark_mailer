require 'spec_helper'

module PostmarkMailer
  class TestMailer < Base
    def email_message
      mail({})
    end
  end

  RSpec.describe Base do
    # Yes I know we shouldn't test private methods but this one is pretty important.
    describe '#mail' do
      it 'returns a MessageDelivery' do
        expect(TestMailer.email_message).to be_instance_of(MessageDelivery)
      end

      context 'prevented delivery' do
        before { allow_any_instance_of(TestMailer).to receive(:prevent_delivery?).and_return(true) }

        it 'returns a NullDelivery' do
          expect(TestMailer.email_message).to be_instance_of(NullDelivery)
        end
      end
    end
  end
end
