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

  def instructor_access
    redirect_to root_path, alert: 'No access!' unless @user_authenticated && @user_authenticated.type == 'Instructor'
  end

  def student_access
    redirect_to root_path, alert: 'No access!' unless @user_authenticated && @user_authenticated.type == 'Student'
  end

  def admin_access
    redirect_to root_path, alert: 'No access!' unless @user_authenticated && @user_authenticated.type == 'Admin'
  end

  def student_admin_access
    redirect_to root_path, alert: 'No access!' unless @user_authenticated && ['Admin', 'Student'].include?(@user_authenticated.type)
  end

  def instructor_admin_access
    redirect_to root_path, alert: 'No access!' unless @user_authenticated && ['Admin', 'Instructor'].include?(@user_authenticated.type)
  end

  def instructor_student_access
    redirect_to root_path, alert: 'No access!' unless @user_authenticated && ['Student', 'Instructor'].include?(@user_authenticated.type)
  end

  protect_from_forgery with: :exception
end
