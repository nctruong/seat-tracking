require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
Dotenv::Railtie.load
module SeatTrackingDemo
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = "Singapore"
    config.eager_load_paths << Rails.root.join("presenters")
    config.eager_load_paths << Rails.root.join("services")
    config.eager_load_paths << Rails.root.join("decorators")
    config.eager_load_paths << Rails.root.join("facades")
    config.eager_load_paths << Rails.root.join("validations")
    config.eager_load_paths << Rails.root.join("data_objects")

    config.common = config_for(:common)
  end
end
