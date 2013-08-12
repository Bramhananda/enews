module Admin
class HomeController < BaseController
  layout 'admin'
  before_action :authenticate_user!
  def index
    @users = User.all
    @article_count = Article.all.size
    @category_count = Category.all.size
    @pictures_count = Picture.all.size
    @galleries_count = Gallery.all.size
    @users_count = User.all.size
  end
end
end