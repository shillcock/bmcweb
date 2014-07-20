if Rails.env.staging? || Rails.env.production?
  MAIL_SETTINGS = {
    address:   "smtp.mandrillapp.com",
    port:      587,
    user_name: ENV["MANDRILL_USERNAME"],
    password:  ENV["MANDRILL_API_KEY"]
  }
end
