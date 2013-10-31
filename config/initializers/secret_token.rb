# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
BreakthroughForMen::Application.config.secret_key_base = ENV['RAILS_SECRET_TOKEN'] || '645d9548ff32b96a4500966986477d85fb69773bb850068cd2cb87dfc8694e08126bb19478613a1e289bcbc00b707401a8a0123a92204951df9d6b0e3f7cc3ee'
