require Rails.root.join('config/initializers/mail')

Rails.application.configure do
  config.cache_classes = true
  config.eager_load = true

  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Enable Rack::Cache to put a simple HTTP cache in front of your application
  # Add `rack-cache` to your Gemfile before enabling this.
  # For large-scale production use, consider using a caching reverse proxy
  # NGINX, varnish or squid.
  # config.action_dispatch.rack_cache = true

  # Disable Rails's static asset server (Apache or NGINX will already do this).
  config.serve_static_assets = false

  config.assets.js_compressor = :uglifier
  # config.assets.css_compressor = :sass
  config.assets.compile = false
  config.assets.digest = true

  # `config.assets.precompile` and `config.assets.version` have moved to config/initializers/assets.rb

  # Specifies the header that your server uses for sending files.
  # config.action_dispatch.x_sendfile_header = 'X-Sendfile' # for Apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for NGINX

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true

  # Decrease the log volume.
  # config.log_level = :info

  # Prepend all log lines with the following tags.
  # config.log_tags = [ :subdomain, :uuid ]

  # Use a different logger for distributed setups.
  # config.logger = ActiveSupport::TaggedLogging.new(SyslogLogger.new)

  # Use a different cache store in production.
  # config.cache_store = :mem_cache_store

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # config.action_controller.asset_host = 'http://assets.example.com'

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

  config.log_formatter = ::Logger::Formatter.new

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = MAIL_SETTINGS
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.default :charset => "utf-8"

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false

  config.middleware.use ExceptionNotification::Rack,
    email: {
      email_prefix: "[BMC:ERROR] ",
      sender_address: "noreply@breakthroughmenscommunity.org",
      exception_recipients: %w{scott+exceptions@breakthroughmenscommunity.org
    }
  }

  #config.middleware.use Mixpanel::Middleware, ENV["MIXPANEL_API_TOKEN"]
end
