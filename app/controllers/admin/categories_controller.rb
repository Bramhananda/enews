module Admin
class CategoriesController < BaseController
  layout 'admin'
  before_action :authenticate_user!
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.select {|i| i.parent.blank? }.sort{|x,y| x.title <=> y.title}.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category = Category.new
     @categories = Category.list.sort{|x,y| x.title <=> y.title}
  end

  # GET /categories/1/edit
  def edit

  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)


      if @category.save
       redirect_to [:admin, @category], flash: {success: "<i class=\"icon-ok\"></i> Kategori başarıyla oluşturuldu.".html_safe}
      else
        render action: 'new'
      end

  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update

      if @category.update(category_params)
        redirect_to [:admin, @category], flash: {success: "<i class=\"icon-ok\"></i> Kategori başarıyla düzenlendi.".html_safe }
      else
       render action: 'edit'
      end

  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy

    if @category.articles.blank?
      @category.destroy
      redirect_to admin_categories_url, flash: {success: "<i class=\"icon-ok\"></i> Kategori başarıyla silindi.".html_safe}
    else
      redirect_to admin_categories_url, flash: {error: "<i class=\"icon-remove\"></i> İçinde haber bulunan kategoriyi silemezsiniz. Lütfen öncelikle bu kategoriye ait haberleri siliniz.".html_safe}
    end



  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:title, :parent_id)
    end
end
end