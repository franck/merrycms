require 'rails/generators'
require 'rails/generators/migration'

module Merrycms
  class InstallVideosGenerator < Rails::Generators::Base
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
              
    def create_translations_migration_files
      migration_template 'create_videos_migration.rb', 'db/migrate/create_videos.rb'
      sleep 1
    end
          
  end
end