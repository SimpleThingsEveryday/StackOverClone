require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Stackower
  # noinspection ALL
  class Application < Rails::Application
    config.generators do|g|
      g.test_framework :rspec,
                       fixtures: true,
                       view_spec: false,
                       helper_specs: false,
                       routing_specs: false,
                       request_rspecs: false,
                       controller_spec: true
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end
 end
end
