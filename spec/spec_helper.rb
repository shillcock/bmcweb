require 'codeclimate-test-reporter'
require 'simplecov'
require 'coveralls'

formatters = [SimpleCov::Formatter::HTMLFormatter]
formatters << Coveralls::SimpleCov::Formatter if ENV['COVERALLS_REPO_TOKEN']
formatters << CodeClimate::TestReporter::Formatter if ENV['CODECLIMATE_REPO_TOKEN']

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[*formatters]
SimpleCov.start 'rails'

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
end

# I18n.enforce_available_locales will default to true in the future.
I18n.enforce_available_locales = false
