class RemoveStudentsController < ApplicationController

  before_action :instructor_admin_access

  def index
    @studentlist = Student.select('"users".*, "student_enrollments"."status", "student_enrollments"."grade"').joins(:student_enrollments).where('student_enrollments.status = :status AND student_enrollments.course_id = :courseid', :status => 'ENROLLED', :courseid => params[:course_id].to_i)
  end

  def destroy
    enrollmentrequest = EnrollmentRequest.where(course_id: params[:course_id], student_id: params[:student_id]).first
    enrollmentrequest.update_attribute(:finished, nil)

    studentenrollment = StudentEnrollment.where(course_id: params[:course_id], student_id: params[:student_id]).first
    studentenrollment.update_attribute(:status, 'UNENROLLED')

    history = History.where(course_id: params[:course_id], user_id: params[:student_id]).first
    history.destroy

    redirect_to remove_students_index_path(:course_id => params[:course_id])
  end
end
