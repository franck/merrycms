module Admin
  class PagesController < BaseController
  
    layout "admin"
  
    before_filter :authenticate_user!
    access_control do
      allow :admin
    end
  
    def index
      @search = Page.includes(:category).search(params[:search])
      @pages = @search.order("created_at desc").page(params[:page])
      puts @pages # hack for kaminari
    end
  
    def new
      @page = Page.new
    end
  
    def create
      @page = Page.new(params[:page])
      if @page.save
        redirect_to admin_pages_path
      else
        render :new
      end
    end
  
    def edit
      @page = Page.find(params[:id])
    end
  
    def update
      @page = Page.find(params[:id])
      if @page.update_attributes(params[:page])
        redirect_to admin_pages_path
      else
        render :edit
      end
    end
  
    def destroy
      page = Page.find(params[:id])
      page.destroy
      redirect_to admin_pages_path
    end
  
    def publish
      page = Page.find(params[:id])
      page.publish!
      redirect_to admin_pages_path
    end
  
    def unpublish
      page = Page.find(params[:id])
      page.unpublish!
      redirect_to admin_pages_path
    end
  
    def archive
      page = Page.find(params[:id])
      page.archive!
      redirect_to admin_pages_path
    end
  
    def unarchive
      page = Page.find(params[:id])
      page.unarchive!
      redirect_to admin_pages_path
    end
    
  end
end