class AuthenticationsController < ApplicationController
  skip_before_action :require_userauth

  def new
  end

  def create
    @user = User.find_by_email(params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:success] = 'Login Successful.'
      redirect_to root_path
    else
      flash[:danger] = 'Cannot Login. Please re-enter email and password.'
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'Logged out successfully.'
    redirect_to login_path
  end
end
