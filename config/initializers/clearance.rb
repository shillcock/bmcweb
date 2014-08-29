Clearance.configure do |config|
  config.mailer_sender = "support@breakthroughformen.org"
  # config.allow_sign_up = false
end

Clearance::SessionsController.layout "clearance"
Clearance::PasswordsController.layout "clearance"
