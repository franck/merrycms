namespace :merrycms do
  
  desc "setup"
  task :setup => :environment do
    system("rails generate merrycms:install")
    Rake::Task['db:migrate'].invoke
    Rake::Task['merrycms:bootstrap'].invoke
    Rake::Task['jquery:install'].invoke
  end

  desc "bootstrap app"
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
  
  desc "cleanup current app"
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