module Admin
  class CategoriesController < ApplicationController
  
    layout "admin"
  
    before_filter :authenticate_user!
    access_control do
      allow :admin
    end
  
    def index
      @categories = Category.arrange
    end
  
    def new
      @category = Category.new
    end
  
    def create
      @category = Category.new(params[:category])
      if @category.save
        redirect_to admin_categories_path
      else
        render :new
      end
    end
  
    def edit
      @category = Category.find(params[:id])
    end
  
    def update
      @category = Category.find(params[:id])
      if @category.update_attributes(params[:category])
        redirect_to admin_categories_path
      else
        render :edit
      end
    end
  
    def destroy
      @category = Category.find(params[:id])
      @category.destroy
      redirect_to admin_categories_path
    end
  
    def sort
      @category = Category.find(params[:id])
      @categories = @category.children_by_position
    end
  
    def sorting
      categories = Category.find(params[:category])
      categories.each do |category|
        category.position = params[:category].index(category.id.to_s)+1
        category.save
      end
    
      render :nothing => true
    end
    
  end
end