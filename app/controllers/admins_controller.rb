class AdminsController < ApplicationController
  before_action :admin_access

  def admin_inactivate_reqs
    @request = Course.where("instructor_req=? and admin_res = ?", true, false)

  end

  def admin_inactivate_reqs_accept
    @course = Course.find_by_id(params[:id])
    if @course.update_attributes(:status => false, :admin_res => true)
      flash[:success]='Course inactivation request Accepted'
      redirect_to(:action => 'manage_course')
    else
      flash[:danger]='Could not accept inactivation request'
      redirect_to(:action => 'manage_course')

    end
  end

  def manage_admin
    @Admins=Admin.all
  end

  def manage_user
    @Students=Student.all
    @Instructors=Instructor.where("is_activeuser=?", true)
  end

  def admin_view_student
    @student = Student.find(params[:id])
    @history = History.where("user_id=?", params[:id])


  end

  def view_instructor

    @instructor = Instructor.find(params[:id])
    @history = History.where("user_id=?", params[:id])

  end

  def create_student
    @student = Student.new
  end

  def create_student_save
    @student=Student.new(student_params)

    if User.where("email=?",@student.email).blank?
      if @student.save
        flash[:success]='Student account created successfully!'
        redirect_to(:action => 'manage_user')
      else
        flash[:danger]='Student creation failed. Please try again!'
        redirect_to(:action => 'create_student')
      end
    else
      flash[:danger] = 'Duplicate email!'
      redirect_to(:action => 'create_student')
    end
  end

  def edit_admin
    @Admin = User.find(session[:user_id])
  end

  def create_instructor_save
    @Instructor=Instructor.new(instructor_params)
    if User.where("email=?",@Instructor.email).blank?
      if @Instructor.save
        flash[:success]='Instructor created successfully!'
        redirect_to(:action => 'manage_user')
      else
        flash[:danger]='Instructor creation failed. Please try again!'
        redirect_to(:action => 'create_instructor')
      end
    else
      flash[:danger] = 'Duplicate email!'
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
    if course_params[:coursenumber].nil? || course_params[:title].nil? || course_params[:description].nil? || course_params[:status].nil? || course_params[:instructor_id].nil? || course_params[:coursenumber].blank? || course_params[:title].blank? || course_params[:description].blank? || course_params[:status].blank? || course_params[:instructor_id].blank?
      flash[:danger] = 'Cannot have blanks!'
      redirect_to(:action => 'manage_course')
    else
      if @Course.update_attributes(course_params)
        flash[:success] = 'Course edit successful!'
        redirect_to(:action => 'manage_course')
      else
        flash[:danger] = 'Please try again and check the Date fields or Instructors are selected properly '
        redirect_to(:action => 'manage_course')
      end
    end
  end

  def edit_admin_save
    @Admin = User.find(session[:user_id])

    if admin_params[:name].nil? || admin_params[:email].nil? || admin_params[:name].blank? || admin_params[:email].blank?
      flash[:danger] = 'Blank fields!'
      redirect_to(:action => 'manage_admin')
    elsif User.where("email = ? AND id NOT IN (?)", admin_params[:email], @Admin.id).blank?
      if @Admin.update_attributes(admin_params)
        flash[:success] = 'Admin details updated successfully!'
        redirect_to(:action => 'manage_admin')
      else
        flash[:danger] = 'Cannot edit Admin!'
        redirect_to(:action => 'manage_admin')
      end
    else
      flash[:danger] = 'Duplicate email!'
      redirect_to(:action => 'manage_admin')
    end
  end

  def delete_admin
    @user = User.find(params[:id])
    if (@user.deletable?)
      if (params[:id].to_i != session[:user_id].to_i)
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
    @course = Course.new
  end

  def create_course_save
    @Course = Course.new(course_params)
    if course_params[:coursenumber].nil? || course_params[:title].nil? || course_params[:description].nil? || course_params[:status].nil? || course_params[:instructor_id].nil? || course_params[:coursenumber].blank? || course_params[:title].blank? || course_params[:description].blank? || course_params[:status].blank? || course_params[:instructor_id].blank?
      flash[:danger] = 'Cannot have blanks!'
      redirect_to(:action => 'manage_course')
    else
      if @Course.save
        @history = History.find_or_create_by(course_id: @Course.id, user_id: @Course.instructor_id) do |h|
          h.role = 'Instructor'
          h.grade = '0'
        end

        flash[:success] = 'Course creation successful!'
        redirect_to(:action => 'manage_course')
      else
        flash[:danger] = 'Cannot create course!'
        redirect_to(:action => 'manage_course')
      end
    end
  end

  def delete_user
    @user = User.find(params[:id])

    if @user.type == 'Student'
      @student = @user
      @message = Message.where("student_id=?",params[:id])
      @message.each do |message|
        message.destroy
      end

      @history = History.where("user_id = ?",params[:id])
      @history.each do |history|
        history.destroy
      end
      @studentenrollments = StudentEnrollment.where("student_id=?", params[:id])
      @studentenrollments.each do |studentenrollments|
        studentenrollments.destroy
      end
      @enrollrequest = EnrollmentRequest.where("student_id=?", params[:id])
      @enrollrequest.each do |enrollrequest|
        enrollrequest.destroy
      end
      if @user.destroy
        flash[:success] = 'Student deleted successfully!'
      else
        flash[:danger] = 'Cannot delete student!'
      end
    end

    if @user.type == 'Instructor'
      @instructor = @user
      if Course.where("instructor_id = ? and (start_date >= ? or end_date >= ?)", params[:id], Date.today, Date.today)
        @course = Course.where("instructor_id = ? and (start_date >= ? or end_date >= ?)", params[:id], Date.today, Date.today)
        @course.each do |course|
          @message = Message.where("instructor_id=?",params[:id])
          @message.each do |message|
            message.destroy
          end

          @history = History.where("course_id=?", course.id)
          @history.each do |history|
            history.destroy
          end
          @material = CoursepageMaterial.where("course_id=?", course.id)
          @material.each do |material|
            material.destroy
          end
          @enrollrequest = EnrollmentRequest.where("course_id=?", course.id)
          @enrollrequest.each do |enrollrequest|
            enrollrequest.destroy
          end
          @studentenrollments = StudentEnrollment.where("course_id=?", course.id)
          @studentenrollments.each do |studentenrollments|
            studentenrollments.destroy
          end
          course.destroy
        end
      end

      if @instructor.update_attribute(:is_activeuser, false)
        flash[:success] = 'Instructor deleted successfully!'
      else
        flash[:danger] = 'Cannot delete Instructor!'
      end
    end
    redirect_to(:action => 'manage_user')
  end

  def create_admin
    @New_admin=Admin.new
  end

  def manage_course
    @current_courses = Course.where(:status => true)
    @past_courses = Course.where(:status => false, :admin_res => false)
    @inactive = Course.where(:status => false, :admin_res => true)
  end

  def view_admin
    @Admin = User.find(params[:id])
  end

  def view_course
    @Course = Course.find(params[:id])
    @material = CoursepageMaterial.where("course_id=?", params[:id])
  end

  def delete_course
    @Course = Course.find(params[:id])
    course = @Course

    @message = Message.where("course_id=?",params[:id])
    @message.each do |message|
      message.destroy
    end

    @history = History.where("course_id=?",course.id)
    @history.each do |history|
      history.destroy
    end

    @material = CoursepageMaterial.where("course_id=?", course.id)
    @material.each do |material|
      material.destroy
    end

    @enrollrequest = EnrollmentRequest.where("course_id=?", course.id)
    @enrollrequest.each do |enrollrequest|
      enrollrequest.destroy
    end

    @studentenrollments = StudentEnrollment.where("course_id=?", course.id)
    @studentenrollments.each do |studentenrollments|
      studentenrollments.destroy
    end

    if course.destroy
      flash[:success] = 'Course deleted successfully!'
      redirect_to(:action => 'manage_course')
    else
      flash[:danger] = 'Cannot delete course!'
      redirect_to(:action => 'manage_course')
    end
  end

  def create
    @Admin=Admin.new(admin_params)

    if User.where("email=?",@Admin.email).blank?
      if @Admin.save
        flash[:success]='Admin created successfully.'
        redirect_to(:action => 'manage_admin')
      else
        flash[:danger]='Admin creation failed. Please try again.'
        redirect_to(:action => 'create_admin')
      end
    else
      flash[:danger] = 'Duplicate email!'
      redirect_to(:action => 'create_admin')
    end
  end

  def admin_request
    @request = Course.where("instructor_req = ? AND admin_res = ?", true, false)
  end

  def admin_accept
    @course = Course.find(params[:id])
    if @course
      @course.update_attributes(:status => false, :admin_res => true)
      flash[:success]='Course inactivated!'
      redirect_to(:action => 'admin_request')
    else
      flash[:danger]='Course could not be inactivated!'
      redirect_to(:action => 'admin_request')
    end
  end

  private
  def instructor_params
    params.require(:instructor).permit(:name, :email, :password)
  end

  def student_params
    params.require(:student).permit(:name, :email, :password)
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
