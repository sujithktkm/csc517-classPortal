class EnrollmentsController < ApplicationController
  before_action :instructor_access, only: [:index, :update]
  def index
    unless params[:course_id].nil?
      @users = Student.joins(:enrollment_requests).where enrollment_requests: {course_id: params[:course_id].to_i, finished: false}
      @enrollment = EnrollmentRequest.where course_id: params[:course_id].to_i, is_fulfilled: false
    end
  end

  def create
  end

  def update
    enrollmentrequest = EnrollmentRequest.find_by_id params[:enrollment_id]
    studentenrollment = StudentEnrollment.where('student_id = :studentid and course_id = :courseid', :studentid => params[:student_id].to_i, :courseid => params[:course_id].to_i).first
    enrollments_update = params[:acceptance]
    course_id = params[:course_id]

    if enrollments_update == 'true'
      enrollmentrequest.update_attribute(:finished, enrollments_update)
      studentenrollment.update_attributes(:status => 'ENROLLED', :grade => '0')
      # history = History.new
      # history.is_current= true;
      # history.user = enrollmentrequest.student
      # history.course = enrollmentrequest.course
      # history.save
      redirect_to enrollments_index_path(:course_id => course_id)
    elsif enrollments_update == 'false'
      enrollmentrequest.update_attribute(:finished, nil)
      studentenrollment.update_attributes(:status => 'UNENROLLED', :grade => nil)
      redirect_to enrollments_index_path(:course_id => course_id)
    end
  end
end
