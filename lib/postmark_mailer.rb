require 'postmark_mailer/version'
require 'postmark_mailer/configuration'
require 'postmark_mailer/base'
require 'postmark_mailer/delivery_job'
require 'postmark_mailer/message_delivery'
require 'postmark_mailer/null_delivery'

module PostmarkMailer
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
