module Admin
class ArticlesController < BaseController
  include ApplicationHelper
  layout 'admin'
  before_action :authenticate_user!
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /articles
  # GET /articles.json
  def index
    if current_user.has_role?(:admin) && !params[:category_id].blank?

        @articles = Article.where(category_id: params[:category_id]).paginate(:page => params[:page], :per_page => 10)
        @category = Category.find(params[:category_id])

    elsif current_user.has_role?(:admin) && params[:active]=="false"

       @articles = Article.where.not(:active=>true).paginate(:page => params[:page], :per_page => 10)
   
    else

        if current_user.has_role?(:admin)
          @articles = Article.all.paginate(:page => params[:page], :per_page => 10)
        else
          @articles = current_user.articles.paginate(:page => params[:page], :per_page => 10)
        end
    end

  end

  def tagged
    @articles = Article.tagged_with(params[:tag], :any => true)
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new

    @article = Article.new
    @article.pictures.build
    @categories = Category.list.sort{|x,y| x.title <=> y.title}
    @article.category_id ||= params[:category_id]

  end

  # GET /articles/1/edit
  def edit
    @article.pictures.build
    @categories = Category.list.sort{|x,y| x.title <=> y.title}
  end

  # POST /articles
  # POST /articles.json
  def create

    @article = Article.new(article_params)

    if article_params[:category_id].blank?
      @article.category = Category.uncategorized
    end

    if current_user.has_role?(:columnist)
      @article.active = false
    end

    if @article.save
      current_user.articles << @article
      redirect_to admin_article_path(@article), flash: {success: "<i class=\"icon-ok\"></i> Haber başarıyla oluşturuldu.".html_safe}

    else

      @article.pictures.build
      render action: 'new'

    end
    
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update


      if @article.update(article_params)

       redirect_to [:admin, @article], flash: {success: "<i class=\"icon-ok\"></i> Haber başarıyla düzenlendi.".html_safe}
      else
       render action: 'edit'
      end

  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy

     redirect_to admin_articles_path, flash: {success: "<i class=\"icon-ok\"></i> Haber başarıyla silindi.".html_safe}


  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :content, :publish_date, :category_id, :active, :tag_list, pictures_attributes: [:image])
    end
end
end