class ContactMailerPreview < ActionMailer::Preview

  def new_message
    message = Message.new(
      name: "Scott",
      email: "scott@gmail.com",
      message: "When is the next class?"
    )
    ContactMailer.new_message(message)
  end
end
