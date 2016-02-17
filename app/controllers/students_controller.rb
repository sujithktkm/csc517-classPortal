class StudentsController < ApplicationController
  skip_before_action :require_userauth, only: [:new, :create]

  before_action :admin_access, only: [:admin_add_students_list, :add_student_to_course]
  before_action :instructor_student_access, only: [:edit, :update]
  before_action :student_access, only: [:show, :search, :search_submit, :course_info, :course_history]

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
      flash[:danger] = 'Cannot edit profile details!'
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
    @course_notification = CoursepageMaterial.where('course_id = :courseid', :courseid => params[:course_id])
  end

  def admin_add_students_list
    if StudentEnrollment.where(course_id: params[:course_id]).blank?
      @student_ids = []
    else
      @studentsEnrolled = StudentEnrollment.where('course_id = :courseid', :courseid => params[:course_id])
      @student_ids = []
      @studentsEnrolled.each do |s|
        @student_ids << s.student_id
      end
    end
  end

  def add_student_to_course
    @course = Course.where(id: params[:course_id]).first
    if Student.where(id: params[:student_id]).blank?
      flash[:danger] = 'Cannot enroll!'
      redirect_to admins_manage_course_path
    elsif StudentEnrollment.joins(:course).select('"student_enrollments".*,"courses"."coursenumber"').where('
    "courses"."coursenumber" = :coursenumber AND "student_enrollments"."student_id" = :student_id AND "student_enrollments"."status" IN (:status)
', :coursenumber => @course.coursenumber, :student_id => params[:student_id], :status => ['ENROLLED', 'PENDING']).blank?
      @enrollmentrequest = EnrollmentRequest.find_or_create_by(course_id: params[:course_id], student_id: params[:student_id]) do |e|
        e.finished = true
      end
      @studentenrollment = StudentEnrollment.find_or_create_by(course_id: params[:course_id], student_id: params[:student_id]) do |s|
        s.status = 'ENROLLED'
        s.grade = '0'
      end
      flash[:success] = 'Enrollment done!'
      redirect_to admins_manage_course_path
    else
      flash[:danger] = 'Sorry, cannot add student. Student is either enrolled in different section of same course or have a pending request'
      redirect_to admins_manage_course_path
    end
  end


  private
  def student_params
    params.require(:student).permit(:name, :email, :password)
  end
end
