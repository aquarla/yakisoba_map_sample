# -*- coding: utf-8 -*-
require_relative 'boot'

# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Yakisoba
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    # ... と言っているが、タイムゾーン設定は application.rbにベタ書き
    # するしかないようだ...
    # https://github.com/rails/rails/issues/24748
    Rails.application.config.time_zone = 'Tokyo'
    Rails.application.config.active_record.default_timezone = :local

    Rails.application.config.autoload_paths += Dir["#{config.root}/lib"]

    # アプリケーション固有の設定は、config/initializers/yakisoba.rb に記載
  end
end
