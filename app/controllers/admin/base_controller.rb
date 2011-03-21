module Admin
  class BaseController < ApplicationController
    
    rescue_from Acl9::AccessDenied, :with => :access_denied
    
    def access_denied
      redirect_to admin_root_path, :alert => t('access_denied')
    end
    
  end
end