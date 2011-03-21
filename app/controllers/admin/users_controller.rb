module Admin
  class UsersController < BaseController
  
    layout "admin"
  
    before_filter :authenticate_user!
    access_control do
      allow :admin
    end
  
    def index
      @users = User.order(:email).page(params[:page])
    end
  
    def new
      @user = User.new
    end
  
    def create
      @user = User.new(params[:user])
    
      @user.set_roles(params[:roles])
        
      if @user.save
        redirect_to admin_users_path
      else
        render :new
      end
    end
  
    def edit
      @user = User.find(params[:id])
    end
  
    def update
      @user = User.find(params[:id])
      @user.set_roles(params[:roles])    
        
      if @user.update_attributes(params[:user])
        redirect_to admin_users_path
      else
        render :edit
      end
    end
  
    def destroy
      @user = User.find(params[:id])
      @user.destroy
      redirect_to admin_users_path
    end
  
  end
end