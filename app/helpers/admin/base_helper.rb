module Admin
  module BaseHelper
        
    def render_subnav      
      if content_for?(:subnav)
        yield(:subnav)
      elsif File.exists?(File.join(File.dirname(__FILE__),'..','..','views',params[:controller],'_subnav.erb'))
        render(:partial=> 'subnav')
      else
        render(:partial=> 'admin/shared/subnav')
      end
    end
    
  end
end