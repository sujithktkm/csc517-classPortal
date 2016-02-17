class EnrollmentsController < ApplicationController
  before_action :instructor_admin_access, only: [:index, :update, :destroy]
  before_action :student_access, only: [:create]

  def index
    unless params[:course_id].nil?
      @users = Student.joins(:enrollment_requests).where enrollment_requests: {course_id: params[:course_id].to_i, finished: false}
      @enrollment = EnrollmentRequest.where course_id: params[:course_id].to_i, finished: false
    end
  end

  def create
    @enrollmentrequest = EnrollmentRequest.find_or_create_by(course_id: params[:course_id], student_id: params[:student_id]) do |e|
      e.finished = false
    end
    @studentenrollment = StudentEnrollment.find_or_create_by(course_id: params[:course_id], student_id: params[:student_id]) do |s|
      s.status = 'PENDING'
      s.grade = '0'
    end
  end

  def update
    enrollmentrequest = EnrollmentRequest.find_by_id params[:enrollment_id]
    studentenrollment = StudentEnrollment.where('student_id = :studentid and course_id = :courseid', :studentid => params[:student_id].to_i, :courseid => params[:course_id].to_i).first
    enrollments_update = params[:acceptance]
    course_id = params[:course_id]

    if enrollments_update == 'true'
      enrollmentrequest.update_attribute(:finished, enrollments_update)
      studentenrollment.update_attributes(:status => 'ENROLLED', :grade => '0')
      @history = History.find_or_create_by(course_id: params[:course_id], user_id: params[:student_id]) do |h|
        h.role = 'Student'
        h.grade = '0'
      end
      if @user_authenticated.type == 'Instructor'
        redirect_to enrollments_index_path(:course_id => course_id)
      elsif @user_authenticated.type == 'Admin'
        redirect_to admins_manage_course_path
      end
    elsif enrollments_update == 'false'
      enrollmentrequest.update_attribute(:finished, nil)
      studentenrollment.update_attributes(:status => 'UNENROLLED', :grade => nil)
      if @user_authenticated.type == 'Instructor'
        redirect_to enrollments_index_path(:course_id => course_id)
      elsif @user_authenticated.type == 'Admin'
        redirect_to admins_manage_course_path
      end
    end
  end

  def destroy
    enrollmentrequest = EnrollmentRequest.where(course_id: params[:course_id], student_id: params[:student_id]).first
    enrollmentrequest.destroy

    studentenrollment = StudentEnrollment.where(course_id: params[:course_id], student_id: params[:student_id]).first
    studentenrollment.destroy

    history = History.where(course_id: params[:course_id], user_id: params[:student_id]).first
    history.destroy

    redirect_to root_path

  end
end
