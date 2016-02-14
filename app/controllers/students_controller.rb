class StudentsController < ApplicationController
  skip_before_action :require_userauth

  before_action :require_userauth, only: [:edit]

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      session[:student_id] = @student.id
      flash[:notice] = "Login successful"
      redirect_to root_path
    else
      flash[:notice] = "Cannot login. Please try again"
      redirect_to new_student_path
    end
  end

  def index
    @student = Student.find_by_id(params[:id])
  end


  def edit # Anurag: This method is editing student details[ Not courses though]
    @student = Student.find(params[:id])
  end

  # edit end

  def update
    @student = Student.find(params[:id])
    if @student.update(student_params)
      redirect_to root_path
    else
      render 'edit'
    end

  end

  def show
  end


  def search
  end

  def search_submit
    # @student_enrollments = StudentEnrollment.where('student_id = :studentid AND course_id = :courseid', :studentid => session[:user_id], :courseid => c.id)
    textbox = "%#{params[:searchbox]}%"
    if textbox.nil?
      @courses = Course.all
    else
      #@courses =  Course.joins('INNER JOIN "course_instructors" ON "course_instructors"."course_id" = "courses"."id" INNER JOIN "users" ON "users"."id" = "course_instructors"."instructor_id" AND "users"."type" IN ('+ "'Instructor'" + ')').where('(courses.coursenumber LIKE :textbox ' + ' OR courses.title LIKE :textbox' + ' OR courses.description LIKE :textbox)' + ' OR users.name LIKE :textbox', :textbox => textbox)
      @courses = Course.where('coursenumber LIKE :textbox OR title LIKE :textbox OR description LIKE :textbox', :textbox => textbox)
      # Add instructor name search**************
    end

  end

  def course_info
    @courseenrollment ||= StudentEnrollment.where('student_id = :studentid AND course_id = :courseid',
                                                  :studentid => session[:user_id], :courseid => params[:course_id].to_i) if(session[:user_id] && params[:course_id])
  end

  private
  def student_params
    params.require(:student).permit(:name, :email, :password)
  end
end
