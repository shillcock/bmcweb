require Rails.root.join('config/initializers/mail')

BreakthroughForMen::Application.configure do
  config.cache_classes = true
  config.eager_load = true

  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Enable Rack::Cache to put a simple HTTP cache in front of your application
  # Add `rack-cache` to your Gemfile before enabling this.
  # For large-scale production use, consider using a caching reverse proxy like nginx, varnish or squid.
  # config.action_dispatch.rack_cache = true

  # Disable Rails's static asset server (Apache or nginx will already do this).
  config.serve_static_assets = false

  config.assets.js_compressor = :uglifier
  # config.assets.css_compressor = :sass
  config.assets.compile = false
  config.assets.digest = true
  config.assets.version = '1.0'

  #config.force_ssl = true

  config.log_level = :info
  config.log_formatter = ::Logger::Formatter.new

  # Use a different cache store in production.
  # config.cache_store = :mem_cache_store

  config.assets.precompile += %w{
    vendor/modernizr.js
    donations.js
    admin.css
    admin.js
    admin/alumni_membership.js
    my.css
    my.js
    my/alumni_membership.js
  }

  HOST = ENV['DOMAIN'] || 'breakthroughmenscommunity.org'
  config.action_mailer.default_url_options = { :host => HOST }

  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = MAIL_SETTINGS
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.default :charset => "utf-8"

  config.middleware.use ExceptionNotification::Rack,
    email: {
      email_prefix: "[BMC:ERROR] ",
      sender_address: "noreply@breakthroughmenscommunity.org",
      exception_recipients: %w{scott+exceptions@breakthroughmenscommunity.org
    }
  }

  #config.middleware.use Mixpanel::Middleware, ENV["MIXPANEL_API_TOKEN"]
end
