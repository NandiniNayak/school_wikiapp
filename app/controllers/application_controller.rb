class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # before_action :authenticate_user!
  def configure_permitted_parameters
   devise_parameter_sanitizer.permit(:sign_up, keys: [:username,:year])
   devise_parameter_sanitizer.permit(:account_update) do |user|
     user.permit(:username,:year, :password, :password_confirmation, :current_password)
   end
 end
end
