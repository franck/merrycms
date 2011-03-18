class Role < ActiveRecord::Base
  
  ROLES = ["admin"]
  
  acts_as_authorization_role
end
