class AdminsController < ApplicationController
  def manage_admin

    @Admins=Admin.all
  end

  def manage_course
  end

  def manage_user
    @Students=Student.all
    @Instructors=Instructor.all

  end

  def edit_admin
    @Admin = User.find(session[:user_id])
  end

  def create_instructor_save

    @Instructor=Instructor.new(instructor_params)
    if @Instructor.save
      flash[:success]='Instructor created successfully!'
      redirect_to(:action => 'manage_user')
    else
      flash[:danger]='Instructor creation failed. Please try again!'
      redirect_to(:action => 'create_instructor')
    end

  end

  def create_instructor
    @Instructor=Instructor.new
  end

  def edit_course
    @Course = Course.find(params[:id])

  end

  def edit_admin_course_save
    @Course = Course.find(params[:id])
    @Course.update_attributes(course_params)
    flash[:success] = 'Course edit successful!'
    redirect_to(:action => 'manage_course')

  end

  def edit_admin_save
    @Admin = User.find(session[:user_id])
    @Admin.update_attributes(admin_params)
    flash[:success] = 'Admin details updated successfully!'
    redirect_to(:action => 'manage_admin')
  end

  def delete_admin
    @user = User.find(params[:id])
    if (@user.deletable?) && (params[:id].to_i != session[:user_id].to_i)
      @user.destroy
      flash[:success] = 'Admin deleted successfully!'
      redirect_to(:action => 'manage_admin')
    else
      flash[:danger] = 'Cannot delete Super Admin!!'
      redirect_to(:action => 'manage_admin')
    end
  end

  def create_course
    @Course = Course.new
  end

  def create_course_save
    @Course = Course.new(course_params)
    @Course.save
    flash[:success] = 'Course creation successful!'
    redirect_to(:action => 'manage_course')

  end

  def delete_user
    User.find(params[:id]).destroy
    flash[:success] = 'User deleted successfully!'
    redirect_to(:action => 'manage_user')
  end

  def create_admin
    @New_admin=Admin.new
  end

  def manage_course
    @Course = Course.all

  end

  def view_admin
    @Admin = User.find(params[:id])
  end

  def view_course
    @Course = Course.find(params[:id])

  end

  def delete_course
    @Course = Course.find(params[:id])
    @Course.destroy
    flash[:success] = 'Course deleted successfully!'
    redirect_to(:action => 'manage_course')

  end

  def create
    @Admin=Admin.new(admin_params)
    if @Admin.save
      flash[:success]='Admin created successfully.'
      redirect_to(:action => 'manage_admin')
    else
      flash[:danger]='Admin creation failed. Please try again.'
      redirect_to(:action => 'manage_admin')
    end
  end

  private
  def instructor_params
    params.require(:instructor).permit(:name, :email, :password)

  end

  def admin_params
    params.require(:admin).permit(:name, :email, :password)

  end

  def admin_edit_params
    params.require(:admin).permit(:name, :email, :password)
    #params.require(:admin).permit(:name)

  end

  def course_params
    params.require(:course).permit(:coursenumber, :title, :description, :start_date, :end_date, :status, :instructor_id)
  end
end
