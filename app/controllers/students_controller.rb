class StudentsController < ApplicationController
  skip_before_action :require_userauth

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      session[:student_id] = @student.id
      redirect_to root_path
    else
      redirect_to new_student_path
    end
  end

  def index

  end

  def show

  end

  private
  def student_params
    params.require(:student).permit(:name, :email, :password)
  end
end
