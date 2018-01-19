# Since we don't have a staging server, we'd like to emulate a production envrironment here too.
# TODO: we could instead set Jenkins environment to production and use the "development"
# for local development as intended.

UsbDistribution::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes
  # config.cache_classes = false
  config.cache_classes = true

  # Do not eager load code on boot.
  # config.eager_load = false
  config.eager_load = true

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled
  # if Rails.root.join('tmp/caching-dev.txt').exist?
  #   config.action_controller.perform_caching = true
  #   config.cache_store = :memory_store
  #   config.public_file_server.headers = {
  #     'Cache-Control' => "public, max-age=#{2.days.seconds.to_i}"
  #   }
  # else
  #   config.action_controller.perform_caching = false
  #   config.cache_store = :null_stor
  # end
  config.action_controller.perform_caching = true
  config.cache_store = :memory_store
  config.public_file_server.headers = {
    'Cache-Control' => "public, max-age=#{2.days.seconds.to_i}"
  }

  # Disable Rails's static asset server (Apache or nginx will already do this).
  config.serve_static_assets = true

  # Compress JavaScripts and CSS.
  config.assets.js_compressor = :uglifier
  # config.assets.css_compressor = :sass

  # Do not fallback to assets pipeline if a precompiled asset is missed.
  config.assets.compile = false

  # Generate digests for assets URLs.
  config.assets.digest = true

  # Version of your assets, change this if you want to expire all your assets.
  config.assets.version = '1.0'

  # Specifies the header that your server uses for sending files.
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  config.force_ssl = true

  # Set to :debug to see everything in the log.
  config.log_level = :debug

  # Prepend all log lines with the following tags.
  # config.log_tags = [ :subdomain, :uuid ]

  # Use a different logger for distributed setups.
  # config.logger = ActiveSupport::TaggedLogging.new(SyslogLogger.new)

  # Use a different cache store in production.
  # config.cache_store = :mem_cache_store

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # config.action_controller.asset_host = "http://assets.example.com"

  # Precompile additional assets.
  # application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
  # config.assets.precompile += %w( search.js )

  # Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
  # config.action_mailer.raise_delivery_errors = false

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found).
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  # Disable automatic flushing of the log to improve performance.
  # config.autoflush_log = false

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new

  config.eager_load_paths += %W(#{config.root}/lib/modules)

  # Initialize the Service Now gem
  ServiceNow::Configuration.configure(:sn_url => ENV['SN_INSTANCE'], :sn_username => ENV['SN_USERNAME'], :sn_password => ENV['SN_PASSWORD'])

  config.custom = ActiveSupport::OrderedOptions.new
  #config.custom.cardSwiprApiURL = 'https://gw-dev.its.yale.edu/soa-gateway/cardswipr/people/data'
  config.custom.cardSwiprApiURL = 'https://gw-dev.its.yale.edu/soa-gateway/v2/identity'
end
