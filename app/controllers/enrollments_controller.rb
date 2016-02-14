class EnrollmentsController < ApplicationController
  def index
  end

  def create
    @enrollmentrequest = EnrollmentRequest.find_or_create_by(course_id: params[:course_id], student_id: params[:student_id])
    @studentenrollment = StudentEnrollment.find_or_create_by(course_id: params[:course_id], student_id: params[:student_id]) do |s|
      s.status = 'PENDING'
      s.grade = '0'
    end
  end

  def update
  end
end
