require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module BreakthroughForMen
  class Application < Rails::Application
    # config.force_ssl = (ENV["ENABLE_HTTPS"] == "yes")

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Pacific Time (US & Canada)'
    # Time.zone.now.utc.iso8601 #=> "2012-03-16T14:55:33Z"

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.generators do |g|
        g.test_framework :rspec,
            fixtures: false,
            view_specs: false,
            helper_specs: false,
            routing_specs: false,
            controller_specs: true,
            request_specs: false
        g.fixture_replacement :factory_girl, dir: "spec/factories"
    end

    config.autoload_paths += Dir["#{config.root}/lib"]
  end
end
