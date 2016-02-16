class AdminsController < ApplicationController
  def manage_admin

    @Admins=Admin.all
  end

  def admin_request

    @request = Course.where("instructor_req = ? and admin_res = ?",true,false)

  end

  def admin_accept
    @course = Course.find(params[:id])
    if @course.update_attributes(:admin_res => true, :status => false)
      flash[:success]='Course is inactivated'
      redirect_to(:action => 'admin_request')
    else
      flash[:success]='Course could not be inactivated'
      redirect_to(:action => 'admin_request')
    end

  end

  def manage_user
    @Students=Student.all
    @Instructors=Instructor.where("is_activeuser=?",true)

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

    if @Course.update_attributes(course_params)
    flash[:success] = 'Course edit successful!'
    redirect_to(:action => 'manage_course')
    else
      flash[:success] = 'Countnt edit course!'
      redirect_to(:action => 'manage_course')
    end
  end

  def edit_admin_save
    @Admin = User.find(session[:user_id])

    if @Admin.update_attributes(admin_params)
    flash[:success] = 'Admin details updated successfully!'
    redirect_to(:action => 'manage_admin')
    else
      flash[:success] = 'Could not edit Admin!'
      redirect_to(:action => 'manage_admin')
    end

  end

  def delete_admin
    @user = User.find(params[:id])
    if (@user.deletable?)
      if(params[:id].to_i != session[:user_id].to_i)
      @user.destroy
      flash[:success] = 'Admin deleted successfully!'
      redirect_to(:action => 'manage_admin')
      else
        flash[:danger] = 'Cannot delete Admin!!'
        redirect_to(:action => 'manage_admin')
      end

    else
      flash[:danger] = 'Unauthorized!'
      redirect_to(:action => 'manage_admin')
    end
  end

  def create_course
    @Course = Course.new
  end

  def create_course_save
    @Course = Course.new(course_params)
    if @Course.save
    flash[:success] = 'Course creation successful!'
    redirect_to(:action => 'manage_course')
    else
      flash[:success] = 'Could not create course'
      redirect_to(:action => 'manage_course')
      end

  end

  def delete_user
    @user = User.find(params[:id])

    if @user.type == 'Student'
      @student = @user

      @history = History.where("user_id = ?",params[:id])
      @history.each do |history|
        history.destroy
      end

      @studentenrollments = StudentEnrollment.where("student_id=?",params[:id])
      @studentenrollments.each do |studentenrollments|
        studentenrollments.destroy
      end

      @enrollrequest = EnrollmentRequest.where("student_id=?",params[:id])
      @enrollrequest.each do |enrollrequest|
        enrollrequest.destroy
      end

      if @user.destroy
        flash[:success] = 'Student deleted successfully!'

      else

        flash[:danger] = 'Could not delete student!'

      end
    end


    if @user.type == 'Instructor'
      @instructor = @user

      if Course.where("instructor_id = ? and (start_date > ? or end_date > ?)", params[:id],Date.today,Date.today)
        @course = Course.where("instructor_id = ? and (start_date > ? or end_date > ?)", params[:id],Date.today,Date.today)
        @course.each do |course|

            @history = History.where("course_id=?",course.id)
            @history.each do |history|
              history.destroy
            end

            @material = CoursepageMaterial.where("course_id=?",course.id)
            @material.each do |material|
              material.destroy
            end

            @enrollrequest = EnrollmentRequest.where("course_id=?",course.id)
            @enrollrequest.each do |enrollrequest|
              enrollrequest.destroy
            end

            @studentenrollments = StudentEnrollment.where("course_id=?",course.id)
            @studentenrollments.each do |studentenrollments|
              studentenrollments.destroy
            end







             course.destroy


          end
      end

      if @instructor.update_attribute(:is_activeuser, false)
        flash[:success] = 'Instructor deleted successfully!'


      else
        flash[:danger] = 'Couldnot delete Instructor!'


      end



    end
    redirect_to(:action => 'manage_user')


  end

  def create_admin
    @New_admin=Admin.new
  end

  def manage_course
    @current_courses = Course.where(:status => true)
    @past_courses = Course.where(:status => false)
  end

  def view_admin
    @Admin = User.find(params[:id])
  end

  def view_course
    @Course = Course.find(params[:id])

  end

  def delete_course
    @Course = Course.find(params[:id])
    course = @Course

    @history = History.where("course_id=?",course.id)
    @history.each do |history|
      history.destroy
    end

    @material = CoursepageMaterial.where("course_id=?",course.id)
    @material.each do |material|
      material.destroy
    end

    @enrollrequest = EnrollmentRequest.where("course_id=?",course.id)
    @enrollrequest.each do |enrollrequest|
      enrollrequest.destroy
    end

    @studentenrollments = StudentEnrollment.where("course_id=?",course.id)
    @studentenrollments.each do |studentenrollments|
      studentenrollments.destroy
    end







    if course.destroy

        flash[:success] = 'Course deleted successfully!'
        redirect_to(:action => 'manage_course')
    else
      flash[:error] = 'Could not delete course!'
      redirect_to(:action => 'manage_course')

    end




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
