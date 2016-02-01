class ApplicationMailer < ActionMailer::Base
  default from: config.default_email
  layout 'mailer'
end
