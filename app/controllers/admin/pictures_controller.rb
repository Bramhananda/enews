class Admin::PicturesController < ApplicationController
	layout 'admin'
	before_action :authenticate_user!
  def index
  	@pictures = Picture.all.paginate(:page => params[:page], :per_page => 15)


  end

  def show
  end

  def new
  	@picture = Picture.new
  end

  def create
  	@picture = Picture.new(picture_params)


  	if @picture.save
      if !params[:picture][:gallery_id].blank?
        gallery= Gallery.find(params[:picture][:gallery_id])
        @picture.galleries << gallery
        redirect_to admin_gallery_path(gallery), flash: { success: "<i class=\"icon-ok\"></i> Görsel galeriye başarıyla eklendi.".html_safe}
      else
  		  redirect_to admin_pictures_path, flash: { success: "<i class=\"icon-ok\"></i> Görsel başarıyla eklendi.".html_safe}
      end
  	else
  		render 'new'
  	end
  end

  def edit
  	@picture = Picture.find(params[:id])
    @galleries = Gallery.select { |x| !x.pictures.include?(@picture)}
    @current_galleries = @picture.galleries
    @selectable = true
  end

  def update
  	@picture = Picture.find(params[:id])

  	if @picture.update(picture_params)
  		redirect_to admin_pictures_path, flash: { success: "<i class=\"icon-ok\"></i> Görsel başarıyla düzenlendi.".html_safe}
  	else
  		render 'edit'
  	end
  end


  def destroy
  	Picture.find(params[:id]).destroy
    if !params[:gallery_id].blank?
  	 redirect_to admin_gallery_path(params[:gallery_id]), flash: { success: "<i class=\"icon-ok\"></i> Görsel galeriden silindi.".html_safe}
    elsif !params[:article_id].blank?
      redirect_to edit_admin_article_path(params[:article_id]), flash: { success: "<i class=\"icon-ok\"></i> Görsel galeriden silindi.".html_safe}
    else
       redirect_to admin_pictures_path, flash: { success: "<i class=\"icon-ok\"></i> Görsel silindi.".html_safe}
    end
  end

  def select_gallery_for_picture
    @gallery = Gallery.find(params[:id])
    @picture = Picture.find(params[:picture_id])
    if @picture.galleries << @gallery
      @okay = true
    end

  end

  def remove_gallery_for_picture
    @gallery = Gallery.find(params[:id])
    @picture = Picture.find(params[:picture_id])
    if @picture.galleries.delete(@gallery)
      @okay = true
    end

  end

  def selectable_galleries
    @picture = Picture.find(params[:id])
    @galleries = Gallery.select { |x| !x.pictures.include?(@picture)}
    @selectable = true
  end

  private

  def picture_params
      params.require(:picture).permit(:title, :image, :gallery_id)
    end
end
