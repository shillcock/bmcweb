class ContactMailer < ActionMailer::Base
  default from: "Breakthrough Men's Community <scott@breakthroughformen.org>"
  default to: "scott@breakthroughformen.org"

  def new_message(message)
    @name = message.name
    @email = message.email
    @message = message.message
    @ip_address = message.remote_ip
    @user_agent = message.user_agent

    mail(to: "#{@name} <#{@email}>".html_safe,
         cc: 'scott@breakthroughformen.org',
         subject: "Fwd: Contact Form")
  end
end
