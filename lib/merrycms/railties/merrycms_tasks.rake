namespace :merrycms do

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

end