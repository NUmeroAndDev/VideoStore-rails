require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module VideoStore
  class Application < Rails::Application
    # config.active_record.raise_in_transactional_callbacks = true
  end
end
