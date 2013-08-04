# app/controllers/users/registrations_controller.rb

class Admin::RegistrationsController < Devise::RegistrationsController



  layout 'admin'

def new
  super
end

  def create
    resource = User.new(user_params)
    if resource.save
      sign_in resource
      redirect_to admin_root_path, :notice=>{ :success=>"Hesabınız başarıyla oluşturuldu."}
    else
      clean_up_passwords(resource)
      render :new
    end
  end



  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  private :user_params
end