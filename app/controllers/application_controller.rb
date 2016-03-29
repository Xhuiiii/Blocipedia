class ApplicationController < ActionController::Base
	include Pundit
	rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:username, :email, :password, :password_confirmation, :remember_me)}
    devise_parameter_sanitizer.for(:sign_in) {|u| u.permit(:login, :username, :email, :password, :remember_me)}
    devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:username, :email, :password, :password_confirmation, :current_password)}
  end
  
  private 
  def user_not_authorized
		flash[:alert] = "Access denied."
    #Send to page they came from or root page.
  	redirect_to(request.referrer || root_path)
	end
end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.