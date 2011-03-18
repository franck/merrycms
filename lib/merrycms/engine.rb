require 'merrycms'
require 'rails'
require 'devise'
require 'acl9'
require 'transitions'
require 'active_record/transitions'
require 'RedCloth'
require 'friendly_id'
require 'nested_set'
require 'i18n/active_record'
require 'merrycms/rails/routes'
require 'kaminari'

module Merrycms
  class Engine < Rails::Engine
    
    # I18n config
    #config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '*', '*.{rb,yml}').to_s]
    config.i18n.load_path += Dir[File.join(File.dirname(__FILE__), '../../config/locales/*/admin/*.{rb,yml}')]
    config.i18n.default_locale = :fr

    # JavaScript files you want as :defaults (application.js is always included).
    config.action_view.javascript_expansions[:defaults] = %w(jquery jquery-ui.min rails)
    
    config.to_prepare { 
      Devise::SessionsController.layout "login" 
      Devise::PasswordsController.layout "login"
      Devise::UnlocksController.layout "login"
      Devise::RegistrationsController.layout "login"
    }
    
    rake_tasks do
      load "merrycms/railties/merrycms_tasks.rake"
    end
    
  end
end
