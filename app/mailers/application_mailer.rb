class ApplicationMailer < ActionMailer::Base
  default from: ENV['EXCEPTION_SENDER_EMAIL']
  layout 'mailer'
end
