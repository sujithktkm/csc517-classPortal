class CoursesController < ApplicationController
  before_action :require_userauth, :instructor_access

  def show
    @course = Course.find_by_id(params[:id])
    @coursepage_material = CoursepageMaterial.find_by(course_id: @course.id) if @course
    @material = CoursepageMaterial.where("course_id=?", params[:id])
  end

  def list_courses
    @courseList_current = Course.where('instructor_id = :instructorid AND status = :status', :instructorid => @user_authenticated.id, :status => true)
    @courseList_past = Course.where('instructor_id = :instructorid AND status = :status', :instructorid => @user_authenticated.id, :status => false)
  end

  def course_inactivate_request
    @course = Course.find_by_id(params[:id])
    if @course.update_attribute(:instructor_req, true)
            flash[:success]='Course inactivation request sent'
            redirect_to(course_path)
    else
        flash[:success]='Could not send course inactivation request'
        redirect_to(course_path)

      end


  end

end
