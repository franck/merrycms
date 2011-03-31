module Admin
  class VideosController < BaseController
  
    layout "admin"

    before_filter :authenticate_user!
    access_control do
      allow :admin
    end
  
    def index
      @search = Video.search(params[:search])
      @videos = @search.order(:title).page(params[:page])
    end
    
    def show
      @video = Video.find(params[:id])
    end
  
    def new
      @video = Video.new
      3.times {  @video.sources.build }
    end
  
    def create
      @video = Video.new(params[:video])
      if @video.save
        redirect_to admin_videos_path
      else
        render :new
      end
    end
  
    def edit
      @video = Video.find(params[:id])
      n = 3 - @video.sources.size
      n.times {  @video.sources.build }
    end
  
    def update
      @video = Video.find(params[:id])
      if @video.update_attributes(params[:video])
        redirect_to admin_videos_path
      else
        render :edit
      end
    end
  
    def destroy
      @video = Video.find(params[:id])
      @video.destroy
      redirect_to admin_videos_path
    end
  
  end
end