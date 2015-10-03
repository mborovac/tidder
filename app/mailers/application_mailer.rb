class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@tidder.com"
  layout 'mailer'
end
