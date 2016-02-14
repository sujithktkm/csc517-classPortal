class CoursesController < ApplicationController
  skip_before_action :require_userauth
  before_action :require_userauth

  def show
    @course = Course.find_by_id(params[:id])
    @coursepage_material = CoursepageMaterial.find_by(course_id: @course.id) if @course
  end

  def list_courses
    @courseList = Course.joins(:course_instructors).where(course_instructors: { instructor_id: @user_authenticated.id})
  end

  def content

  end

end
