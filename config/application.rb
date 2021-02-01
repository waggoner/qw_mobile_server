require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MobileApi
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.action_mailer.default_url_options = { host: "quantwrestling.com" }

    config.action_mailer.delivery_method = :sendgrid_actionmailer
    config.action_mailer.sendgrid_actionmailer_settings = {
      api_key: Rails.application.credentials.sendgrid[:api_key],
      raise_delivery_errors: true
    }

  end
end
