class GradesController < ApplicationController
  before_action :instructor_admin_access, only: [:edit, :update]
  before_action :enrollmentid, only: [:edit]

  def show

  end

  def enrollmentid
    id = StudentEnrollment.select('id').where('student_enrollments.student_id = :studentid and student_enrollments.course_id = :courseid', :studentid => params[:student_id].to_i, :courseid => params[:course_id].to_i)
    id.each do |id|
      params[:enrollment_id] = id.id
    end
  end

  def edit
    if params[:enrollment_id].nil? || params[:enrollment_id].blank?
      flash[:danger] = 'Cannot be blank!'
      if @user_authenticated.type == 'Admin'
        redirect_to admins_manage_course_path
      elsif @user_authenticated.type == 'Instructor'
        redirect_to courses_list_courses_path
      end
    else
      @studentenrollments = StudentEnrollment.find(params[:enrollment_id])
    end
    # @studentenrollments = StudentEnrollment.where('student_enrollments.student_id = :studentid and student_enrollments.course_id = :courseid', :studentid => params[:student_id].to_i, :courseid => params[:course_id].to_i)
  end

  def update
    @studentenrollments = StudentEnrollment.find(params[:enrollment_id])
    history = History.where('course_id = :courseid AND user_id = :studentid', :courseid => params[:course_id].to_i, :studentid => params[:student_id].to_i).first
    if @studentenrollments.update(grades_params)
      history.update_attribute(:grade, grades_params[:grade])
      # session[:material_id] = @student.id
      flash[:success] = 'Grade updated!'
      if @user_authenticated.type == 'Instructor'
        redirect_to courses_list_courses_path
      else
        redirect_to admins_manage_course_path
      end
    else
      flash[:danger] = 'Cannot update grade. Please try again'
      redirect_to grades_edit_path
    end
  end

  private
  def grades_params
    params.require(:student_enrollment).permit(:grade, :student_id, :course_id)
  end

  def students_list
    @students = Student.all
    # @students = Student.joins(:student_enrollments).where('student_enrollments.status = :status AND student_enrollments.course_id = :courseid', :status => 'ENROLLED', :courseid => params[:course_id].to_i)
    # debugger
  end
end
