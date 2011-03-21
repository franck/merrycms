module Admin
  module UsersHelper
  
    def display_user_roles(user)
      logger.debug("ROLES : #{user.role_list}")
      user.role_list.map{|r| r.name if r }.join(', ')
    end
  
  end
end