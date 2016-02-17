class InstructorsController < ApplicationController
  def edit
    @instructor = Instructor.find(params[:id])
  end

  def update
    @instructor = Instructor.find(params[:id])
    if @instructor.update(instructor_params)
      flash[:success] = 'Updated profile!'
      redirect_to root_path
    else
      flash[:danger] = 'Cannot edit profile details!'
      render 'edit'
    end
  end

  private
  def instructor_params
    params.require(:instructor).permit(:name, :email, :password)
  end

end
