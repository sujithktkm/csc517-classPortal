class StudentsController < ApplicationController
  skip_before_action :require_userauth, only: [:new, :create]

  before_action :student_access, only: [:edit, :update, :show, :search, :search_submit, :course_info, :course_history]

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      session[:student_id] = @student.id
      flash[:success] = 'Student created successfully'
      redirect_to root_path
    else
      flash[:danger] = 'Cannot create Student. Please try again'
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
      flash[:success] = 'Updated profile!'
      redirect_to root_path
    else
      render 'edit'
    end

  end

  # Display my courses
  def show
    @courseinfo = StudentEnrollment.select('"student_enrollments"."grade", "courses".*').joins(:course).where('"student_enrollments"."student_id" = :studentid AND "student_enrollments"."status" = :enrolled', :studentid => session[:user_id], :enrolled => "ENROLLED")
  end


  def search
  end

  def search_submit
    # @student_enrollments = StudentEnrollment.where('student_id = :studentid AND course_id = :courseid', :studentid => session[:user_id], :courseid => c.id)
    textbox = "%#{params[:searchbox]}%"
    if params[:status] == 'false'
      status_bool = false
    elsif params[:status] == 'true'
      status_bool = true
    else
      status_bool = [true, false]
    end

    if textbox.nil?
      @courses = Course.all
    else
      #@courses =  Course.joins('INNER JOIN "course_instructors" ON "course_instructors"."course_id" = "courses"."id" INNER JOIN "users" ON "users"."id" = "course_instructors"."instructor_id" AND "users"."type" IN ('+ "'Instructor'" + ')').where('(courses.coursenumber LIKE :textbox ' + ' OR courses.title LIKE :textbox' + ' OR courses.description LIKE :textbox)' + ' OR users.name LIKE :textbox', :textbox => textbox)
      @courses = Course.select('"courses".*, "users"."name"').joins('INNER JOIN "users" ON "users"."id" = "courses"."instructor_id"').where('("courses"."coursenumber" ILIKE :textbox OR "courses"."title" ILIKE :textbox OR "courses"."description" ILIKE :textbox OR "users"."name" ILIKE :textbox) AND "courses"."status" IN (:status)', :textbox => textbox, :status => status_bool)
      # Add instructor name search**************
    end

  end

  def course_info
    @courseenrollment ||= StudentEnrollment.where('student_id = :studentid AND course_id = :courseid',
                                                  :studentid => session[:user_id], :courseid => params[:course_id].to_i) if (session[:user_id] && params[:course_id])

  end

  def course_history
    @student = Student.find(session[:user_id])
    @history_data ||= History.select('"histories"."grade"', '"courses"."title"', '"courses"."description"', '"courses"."end_date"').joins(:course).where('user_id = :studentid', :studentid => @student.id)

  end

  def course_notification
    @course_notification = CoursepageMaterial.where('course_id = :courseid',:courseid => params[:course_id] )
    session[:courseid] = params[:course_id]
  end


  private
  def student_params
    params.require(:student).permit(:name, :email, :password)
  end
end
