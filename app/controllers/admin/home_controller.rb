module Admin
class HomeController < BaseController
  layout 'admin'
  before_action :authenticate_user!
  def index
    @users = User.all
  end
end
end