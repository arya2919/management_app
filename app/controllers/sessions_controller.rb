# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]
  
  def new
    redirect_to dashboard_path if logged_in?
  end
  
  def create
    user = User.find_by(email: params[:email])
    
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to dashboard_path, notice: 'Successfully logged in!'
    else
      flash.now[:alert] = 'Invalid email or password'
      render :new
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: 'Successfully logged out!'
  end
end