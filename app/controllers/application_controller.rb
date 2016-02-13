class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :require_userauth
  helper_method :check_auth

  def check_auth
    @user_authenticated ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_userauth
    redirect_to login_path unless check_auth
  end




  protect_from_forgery with: :exception
end
