class Admin::PasswordsController < Devise::PasswordsController
  layout 'admin'
  def resource_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  private :resource_params
end