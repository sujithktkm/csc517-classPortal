class CoursesController < ApplicationController
  skip_before_action :require_userauth
  before_action :require_userauth

  def show
    @course = Course.find_by_id(params[:id])
    @coursepage_material = CoursepageMaterial.find_by(course_id: @course.id) if @course
  end

  def list_courses
    @courseList = Course.where('instructor_id = :instructorid', :instructorid => @user_authenticated.id)
  end

  def inactive_request
    @course = Course.find(params[:id])
    if @course.update_attribute(:instructor_req, true)
      flash[:success]='Course inactivation request sent'
      redirect_to(course_path)
    else
      flash[:success]='Could not send course inactivation request'
      redirect_to(course_path)
    end

  end

end
