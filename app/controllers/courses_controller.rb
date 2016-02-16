class CoursesController < ApplicationController
  skip_before_action :require_userauth
  before_action :require_userauth

  def show
    @course = Course.find_by_id(params[:id])
    @coursepage_material = CoursepageMaterial.find_by(course_id: @course.id) if @course
  end

  def list_courses
    @courseList_current = Course.where('instructor_id = :instructorid AND status = :status', :instructorid => @user_authenticated.id, :status => true)
    @courseList_past = Course.where('instructor_id = :instructorid AND status = :status', :instructorid => @user_authenticated.id, :status => false)
  end

end
