class StudentsController < ApplicationController
  skip_before_action :require_userauth

  before_action :require_userauth, only: [:edit]

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(params)
    if @student.save
      session[:student_id] = @student.id
      redirect_to root_path
    else
      redirect_to new_student_path
    end
  end

  def index

  end


  def edit  # Anurag: This method is editing student details[ Not courses though]
    @student = Student.find(params[:id])
  end # edit end

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

   private
   def student_params
     params.require(:student).permit(:name, :email, :password)
   end
end
