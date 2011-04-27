namespace :merrycms do
  
  desc "setup"
  task :setup => :environment do
    system("rails generate merrycms:install_auth")
    system("rails generate merrycms:install_pages")
    system("rails generate merrycms:install_translations")
    system("rails generate merrycms:install_media")
    system("rails generate jquery:install")
    
    Rake::Task['merrycms:import_assets'].invoke
    
    Rake::Task['db:migrate'].invoke
    Rake::Task['merrycms:bootstrap'].invoke
  end

  desc "Copies all merrycms assets to public/ directory"
  task :import_assets => :environment do
    merrycms_assets = File.expand_path(File.join(File.dirname(__FILE__), '../../../public/'))
    command = "cp -R #{merrycms_assets} #{Rails.root}/"
    puts command
    system(command)
  end

  desc "bootstrap app : create admin user and root category"
  task :bootstrap => :environment do
    create_admins
    create_root_cat
  end
  
  def create_admins
    users = [{ 
      :email => "franck.dagostini@gmail.com",
      :password => "adminadmin",
      :password_confirmation => "adminadmin" 
    }]
    
    for user in users
       u = User.find_or_create_by_email(user)
       u.has_role!('admin')
     end    
  end
  
  def create_root_cat
    Category.find_or_create_by_name("root")
  end
  
  desc "CAUTIOUS : cleanup current app by dropping the DB and removing all migration files"
  task :cleanapp => :environment do
    Rake::Task['db:drop'].invoke
    command = "rm -rf #{Rails.root}/db/migrate/*"
    puts command
    system command
  end
  
  desc "add locale to app"
  task :locale2app => :environment do
    text = <<-EOT

################################################
# Add this snippet in application_controller.rb
################################################

before_filter :set_locale
def set_locale
  I18n.locale = params[:locale]
end

def default_url_options(options={})
  { :locale => I18n.locale }
end

################################################
# And nest your routes with
################################################

scope "/:locale" do
  # your routes here
end

    EOT
    
    puts text
  end

end