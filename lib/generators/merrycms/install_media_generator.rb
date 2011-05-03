require 'rails/generators'
require 'rails/generators/migration'

module Merrycms
  class InstallMediaGenerator < Rails::Generators::Base
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
              
    def create_images_migration_files
      migration_template 'create_images_migration.rb', 'db/migrate/create_images.rb'
      sleep 1
    end
        
    def copy_locale_initializer
      copy_file 'paperclip_initializer.rb', 'config/initializers/paperclip.rb'
    end
    
    def create_documents_migration_files
      migration_template 'create_documents_migration.rb', 'db/migrate/create_documents.rb'
      sleep 1
    end
    
    def create_videos_migration_files
      migration_template 'create_videos_migration.rb', 'db/migrate/create_videos.rb'
      sleep 1
    end
  
  end
end