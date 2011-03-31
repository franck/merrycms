module Admin
  class ImagesController < BaseController
  
    layout "admin"

    before_filter :authenticate_user!
    access_control do
      allow :admin
    end
  
    def index
      @search = Image.search(params[:search])
      @images = @search.order(:title).page(params[:page])
    end
  
    def new
      @image = Image.new
    end
  
    def create
      @image = Image.new(params[:image])
      if @image.save
        redirect_to admin_images_path
      else
        render :new
      end
    end
  
    def edit
      @image = Image.find(params[:id])
    end
  
    def update
      @image = Image.find(params[:id])
      if @image.update_attributes(params[:image])
        redirect_to admin_images_path
      else
        render :edit
      end
    end
  
    def destroy
      @image = Image.find(params[:id])
      @image.destroy
      redirect_to admin_images_path
    end
  
  end
end