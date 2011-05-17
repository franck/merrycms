class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  acts_as_authorization_subject :association_name => :roles
  
  scope :admins, where("roles.name = ?" , "admin").includes(:roles)
  
  def role_list
    roles = Role.all
    user_roles = roles.map{|r| r if self.has_role?(r.name) }
  end
  
  def last_admin?(role="admin")
    last_admin = false
    if role == "admin" and self.has_role?("admin") and User.admins.size == 1
      last_admin = true
    end
    return last_admin
  end
  
  def set_roles(roles)    
    if self.last_admin?
      self.has_no_roles!
      self.has_role!("admin")
    else
      self.has_no_roles!
    end
    
    return unless roles
    for role in roles
      self.has_role!(role)
    end
  end  
  
  protected
  
  def password_required?
    !persisted? || password.present? || password_confirmation.present?
  end
  
end
