class AdminsController < ApplicationController
  def manage_admin

    @Admins=Admin.all
  end
  def manage_course
  end
  def manage_user
    @Students=Student.all

  end
  def show
    @Admin = User.find(session[:user_id])
  end
  def delete_admin
    User.find(params[:id]).destroy
    redirect_to(:action => 'manage_admin')
    end
  def delete_user
    User.find(params[:id]).destroy
    redirect_to(:action => 'manage_user')
  end
  def create_admin
    @New_admin=Admin.new
  end
def view_admin
  @Admin = User.find(params[:id])
end
  def create
    @Admin=Admin.new(admin_params)
   if @Admin.save
     flash[:notice]="Admin created successfully"
     redirect_to(:action => 'manage_admin')
   else
     flash[:notice]="Could not create the Admin"
     redirect_to(:action => 'manage_admin')
   end
    end

private
  def admin_params
    params.require(:admin).permit(:name, :email, :password)

  end
end
