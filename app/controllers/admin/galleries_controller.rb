class Admin::GalleriesController < ApplicationController
	load_and_authorize_resource
	layout 'admin'
	before_action :authenticate_user!
	before_action :set_gallery, only: [:show, :edit, :update, :destroy]

	def index
		@galleries = Gallery.all.order(:created_at=>:desc).paginate(:page=>params[:page])
	end

	def new
		@gallery = Gallery.new
		@gallery.pictures.build
		@article = Article.find(params[:article_id]) if params[:article_id]
	end

	def create
		@gallery = Gallery.new(gallery_params)

	      if @gallery.save

	      	if !params[:gallery][:article_id].blank?
	      		article = Article.find(params[:gallery][:article_id])
	      		@gallery.articles << article
	        	redirect_to admin_gallery_path(@gallery), flash: {success: "<i class=\"icon-ok\"></i> Galeri başarıyla oluşturuldu.".html_safe}
	    	else
	    		redirect_to admin_galleries_path, flash: {success: "<i class=\"icon-ok\"></i> Galeri başarıyla oluşturuldu.".html_safe}
	    	end
	      else
	      @gallery.pictures.build
	     render action: 'new'

	      end

	end

	def show

	end

	def edit

	end

	def update
		if @gallery.update(gallery_params)
       redirect_to admin_galleries_path, flash: {success: "<i class=\"icon-ok\"></i> Galeri başarıyla düzenlendi.".html_safe}
      else
       render action: 'edit'
      end
	end



	def destroy
		if @gallery.pictures.blank?
			@gallery.destroy
			redirect_to admin_galleries_path, flash: { success: "<i class=\"icon-ok\"></i> Galeri silindi.".html_safe}
		else
			redirect_to admin_gallery_path(@gallery), flash: { error: "<i class=\"icon-remove\"></i> Öncelikle galerinin içini boşaltmalısınız.".html_safe}
		end
	end

	private
    # Use callbacks to share common setup or constraints between actions.
    def set_gallery
      @gallery = Gallery.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gallery_params
      params.require(:gallery).permit(:title, :description, pictures_attributes: [:image])
    end
end
