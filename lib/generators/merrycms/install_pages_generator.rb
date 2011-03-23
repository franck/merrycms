require 'rails/generators'
require 'rails/generators/migration'

module Merrycms
  class InstallPagesGenerator < Rails::Generators::Base
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
          
    def create_page_and_category_migration_files
      migration_template 'create_pages_and_categories_migration.rb', 'db/migrate/create_pages_and_categories.rb'
      sleep 1
    end
    
    # pages and categories
    def generate_slugs_table
      invoke 'friendly_id'
    end
    
    def create_translations_migration_files
      migration_template 'create_translations_migration.rb', 'db/migrate/create_translations.rb'
      sleep 1
    end
        
    def copy_locale_initializer
      copy_file 'locale_initializer.rb', 'config/initializers/locale.rb'
    end
  
  end
end