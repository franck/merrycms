require 'rails/generators'
require 'rails/generators/migration'

module Merrycms
  class InstallGenerator < Rails::Generators::Base
    include Rails::Generators::Migration
  
    def self.source_root
      @source_root ||= File.join(File.dirname(__FILE__), 'templates')
    end
  
    def self.next_migration_number(dirname)
      if ActiveRecord::Base.timestamped_migrations
        Time.now.utc.strftime("%Y%m%d%H%M%S")
      else
        "%.3d" % (current_migration_number(dirname) + 1)
      end
    end
  
    # Authentication (Devise)
    def copy_devise_initializer
      copy_file 'devise_initializer.rb', 'config/initializers/devise.rb'
    end
  
    def add_devise_routes
      route 'devise_for :users'
    end
  
    def add_merrycms_routes
      route 'merrycms_routes'
    end
  
    def copy_locales
      directory "../../../../config/locales/fr/admin", "config/locales/fr/admin"
    end
    
    def create_migration_files
      migration_template 'devise_create_users_migration.rb', 'db/migrate/devise_create_users.rb'
      sleep 1
      migration_template 'create_roles_migration.rb', 'db/migrate/create_roles.rb'
      sleep 1
      migration_template 'roles_users_migration.rb', 'db/migrate/roles_users.rb'
      sleep 1
      migration_template 'create_pages_and_categories_migration.rb', 'db/migrate/create_pages_and_categories.rb'
      sleep 1
      migration_template 'create_translations_migration.rb', 'db/migrate/create_translations.rb'
      sleep 1
    end
    
    def copy_stylesheets
      copy_file '../../../../public/stylesheets/reset.css', 'public/stylesheets/reset.css'
      copy_file '../../../../public/stylesheets/font.css', 'public/stylesheets/font.css'
      copy_file '../../../../public/stylesheets/form.css', 'public/stylesheets/form.css'
      copy_file '../../../../public/stylesheets/login.css', 'public/stylesheets/login.css'
      copy_file '../../../../public/stylesheets/admin.css', 'public/stylesheets/admin.css'
    end

    def copy_javascripts
      copy_file '../../../../public/javascripts/admin.js', 'public/javascripts/jquery-ui.js'
      copy_file '../../../../public/javascripts/form.js', 'public/javascripts/form.js'
      copy_file '../../../../public/javascripts/admin.js', 'public/javascripts/admin.js'
      copy_file '../../../../public/javascripts/autoresize.jquery.min.js', 'public/javascripts/autoresize.jquery.min.js'
    end
    
    def copy_images
      directory '../../../../public/images/merrycms', 'public/images/merrycms'
    end
    
    def copy_locale_initializer
      copy_file 'locale_initializer.rb', 'config/initializers/locale.rb'
    end
    
    # pages and categories
    def generate_slugs_table
      invoke 'friendly_id'
    end
  
  end
end