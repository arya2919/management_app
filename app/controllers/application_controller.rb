class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.

  allow_browser versions: :modern
    protect_from_forgery with: :exception
  
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  helper_method :current_user, :logged_in?, :receptionist?, :doctor?
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def logged_in?
    !!current_user
  end
  
  def receptionist?
    current_user&.receptionist?
  end
  
  def doctor?
    current_user&.doctor?
  end
  
  def authenticate_user!
    redirect_to login_path unless logged_in?
  end
  
  def require_receptionist!
    redirect_to root_path unless receptionist?
  end
  
  def require_doctor!
    redirect_to root_path unless doctor?
  end
end
