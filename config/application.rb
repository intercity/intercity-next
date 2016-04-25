require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module IntercityNext
  class Application < Rails::Application
    config.action_controller.action_on_unpermitted_parameters = :raise
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_job.queue_adapter = :sidekiq

    config.generators.assets = false
    config.generators.helper = false

    config.eager_load_paths << Rails.root.join("lib")

    $redis = Redis.new
  end
end
