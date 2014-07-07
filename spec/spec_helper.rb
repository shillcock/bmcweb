require 'simplecov'
require 'coveralls'
# Coveralls.wear!

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start

ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'
require 'shoulda/matchers/integrations/rspec'

require 'sidekiq/testing'
Sidekiq::Logging.logger = nil

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  config.mock_with :mocha
  config.use_transactional_fixtures = false
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"

  # config.expect_with :rspec do |c|
  #   c.syntax = :expect
  # end
end

# I18n.enforce_available_locales will default to true in the future.
I18n.enforce_available_locales = false
