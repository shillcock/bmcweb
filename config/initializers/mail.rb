if Rails.env.staging? || Rails.env.production?
  MAIL_SETTINGS = {
    address:   "smtp.mandrillapp.com",
    port:      587,
    user_name: ENV["MANDRILL_USERNAME"],
    password:  ENV["MANDRILL_API_KEY"]
  }
end
# config.action_mailer.delivery_method = :smtp
# config.action_mailer.smtp_settings = {
#   :user_name => '2254346df566f4eaa',
#   :password => '783d67ebb8a5b8',
#   :address => 'mailtrap.io',
#   :domain => 'mailtrap.io',
#   :port => '2525',
#   :authentication => :cram_md5,
#   :enable_starttls_auto => true
# }
