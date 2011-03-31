module Admin
  class DocumentsController < BaseController
  
    layout "admin"

    before_filter :authenticate_user!
    access_control do
      allow :admin
    end
  
    def index
      @search = Document.search(params[:search])
      @documents = @search.order(:title).page(params[:page])
    end
  
    def new
      @document = Document.new
    end
  
    def create
      @document = Document.new(params[:document])
      if @document.save
        redirect_to admin_documents_path
      else
        render :new
      end
    end
  
    def edit
      @document = Document.find(params[:id])
    end
  
    def update
      @document = Document.find(params[:id])
      if @document.update_attributes(params[:document])
        redirect_to admin_documents_path
      else
        render :edit
      end
    end
  
    def destroy
      @document = Document.find(params[:id])
      @document.destroy
      redirect_to admin_documents_path
    end
  
  end
end