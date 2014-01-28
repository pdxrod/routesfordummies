require File.expand_path('../boot', __FILE__)

# require 'rails/all'
# No database: replace the above line with these lines and remove mysql gem etc. from Gemfile     
require "action_controller/railtie"
require "action_mailer/railtie"
require "rails/test_unit/railtie"
require "sprockets/railtie"
# See http://stackoverflow.com/questions/3954307/rails-3-how-do-i-avoid-database-altogether

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line.
  Bundler.require(*Rails.groups(:assets => %w(development test)))
  # If you want your assets lazily compiled in production, use this line.
  # Bundler.require(:default, :assets, Rails.env)
end

module Rockonruby
  class Application < Rails::Application
    config.encoding = "utf-8"

    config.filter_parameters += [:password]
    config.filter_parameters += [:password_confirmation]

  #  config.active_record.dependent_restrict_raises = false

    config.assets.enabled = true

    config.assets.version = '1.0'
  end
end





