#Braintree::Configuration.environment = Rails.env.production? ? :production : :sandbox
Braintree::Configuration.environment = :sandbox
Braintree::Configuration.merchant_id = ENV["BRAINTREE_MERCHANT_ID"]
Braintree::Configuration.public_key  = ENV["BRAINTREE_PUBLIC_KEY"]
Braintree::Configuration.private_key = ENV["BRAINTREE_PRIVATE_KEY"]

Rails.configuration.braintree = {
  client_side_encryption_key: ENV['BRAINTREE_CLIENT_SIDE_ENCRYPTION_KEY']
}
