class CoursesController < ApplicationController
  def index
    @course = Course.find_by_id(params[:id])
  end

  def list
    @courseList = Course.joins(:course_instructors).where(course_instructors: { instructor_id: @user_authenticated })
  end

  def show
    @currCourse = Course.find_by_id(params[:id])
    if @currCourse

    end
  end

  def content
    @currCourse = Course.find_by_id(params[:id])
  end

  def add_content
    debugger
    @content = CoursepageMaterial.new(coursepage_params)
    if @content.save
      flash[:notice] = "#{@content.title} material added."
      redirect_to '/courses/show'
    else
      flash[:notice] = "Cannot added material. Please try again"
      redirect_to '/courses/content'
    end
  end
  def grades

  end

  def enrollments

  end

  private
  def coursepage_params
    params.require(:coursepage_materials).permit(:title, :description, :type, :course_id)
  end
end
