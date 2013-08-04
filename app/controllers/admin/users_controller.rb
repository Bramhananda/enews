module Admin
class UsersController < BaseController
  layout 'admin'
  before_filter :authenticate_user!

  def index
    authorize! :index, @user, :message => 'Buna yetkiniz bulunmuyor.'
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit

  end

  def update
    authorize! :update, @user, :message => 'Buna yetkiniz bulunmuyor.'
    @user = User.find(params[:id])
    if @user.update_attributes(user_params, :as => :admin)
      redirect_to admin_users_path, :notice => "Kullanıcı güncellendi."
    else
      redirect_to admin_users_path, :alert => "Kullanıcı güncellenemedi."
    end
  end

  def destroy
    authorize! :destroy, @user, :message => 'Buna yetkiniz bulunmuyor.'
    user = User.find(params[:id])
    unless user == current_user
      user.destroy
      redirect_to admin_users_path, :notice => "Kullanıcı silindi."
    else
      redirect_to admin_users_path, :notice => "Kendinizi silemezsiniz."
    end
  end

private

def user_params
   params.require(:user).permit(:name, :email, :password, :password_confirmation, :role_ids)
end

end
end