module Admin
  class TranslationsController < ApplicationController
    respond_to :html, :json
  
    layout "admin"
  
    before_filter :authenticate_user!
    access_control do
      allow :admin
    end
  
    def index
      @pending_translations = Translation.pending.group_by{|t| t.locale }
      @all_translations = Translation.not_pending.group_by{|t| t.locale }
    end
  
    def new
      if params[:type] && params[:type] == "pending"
        @translations = Translation.search_query(params[:query]).pending.where(:locale => params[:language]).page(params[:page]).per(10)
      else
        @translations = Translation.search_query(params[:query]).not_pending.where(:locale => params[:language]).page(params[:page]).per(10)
      end
    end
  
    def create
      params[:translations].values.each do |record|
        logger.debug("DESTROY : #{record[:destroy]}")
        destroy_record = record.delete(:destroy)
        if  destroy_record == "false"
          record_id = record.delete(:id)
          translation = Translation.find(record_id)
          logger.debug("TRANSLATION : #{translation.inspect}")
          logger.debug("RECORD : #{record.inspect}")
          translation.update_attributes(record)
        end
      end
      redirect_to admin_translations_path, :notice => t('translations.notice.translation_added')
    end
  
    def destroy
      @translation = Translation.find(params[:id])
      @translation.destroy
      respond_with(@translation) do |format|
        format.html { redirect_to new_admin_translation_path(:type => params[:type], :language => params[:language]) }
        format.js
      end
    end
  
    def dump
      Translation.dump_all
      redirect_to admin_translations_path, :notice => t('translations.notice.dumped')
    end

  end
end