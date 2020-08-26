require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CardswiprNew
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.autoload_paths += ["#{config.root}/lib"]

    # Set time zone
    config.time_zone = 'Eastern Time (US & Canada)'

    ActionDispatch::Callbacks.after do      
      # Reload the factories
      return unless (Rails.env.development? || Rails.env.test?)

      unless FactoryBot.factories.blank?
        FactoryBot.factories.clear
        FactoryBot.find_definitions
      end
    end  
  end
end
