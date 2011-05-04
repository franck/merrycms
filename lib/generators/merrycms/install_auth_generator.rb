require 'rails/generators'
require 'rails/generators/migration'

module Merrycms
  class InstallAuthGenerator < Rails::Generators::Base
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
    
    def create_devise_migration_files
      migration_template 'devise_create_users_migration.rb', 'db/migrate/devise_create_users.rb'
      sleep 1
    end
    
    def add_merrycms_routes
      route 'merrycms_routes'
    end
    
    def create_user_management_migration_files
      migration_template 'create_roles_migration.rb', 'db/migrate/create_roles.rb'
      sleep 1
      migration_template 'roles_users_migration.rb', 'db/migrate/roles_users.rb'
      sleep 1
    end    
  
  end
end