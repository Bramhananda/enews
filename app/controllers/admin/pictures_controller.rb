class Admin::PicturesController < ApplicationController
	layout 'admin'
	before_action :authenticate_user!
  def index
  	@pictures = Picture.all

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
  end

  def new
  	@picture = Picture.new
  end

  def create
  	@picture = Picture.new(picture_params)

  	if @picture.save
  		redirect_to admin_pictures_path, flash: { success: "Görsel başarıyla eklendi."}
  	else
  		render 'new'
  	end
  end

  def edit
  	@picture = Picture.find(params[:id])
  end

  def update
  	@picture = Picture.find(params[:id])

  	if @picture.update(picture_params)
  		redirect_to admin_pictures_path, flash: { success: "Görsel başarıyla düzenlendi."}
  	else
  		render 'edit'
  	end
  end


  def destroy
  	Picture.find(params[:id]).destroy
  	redirect_to admin_pictures_path, flash: { success: "Görsel silindi."}
  end

  private

  def picture_params
      params.require(:picture).permit(:title, :image)
    end
end
