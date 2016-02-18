class InstructorsController < ApplicationController
  def edit
    @instructor = Instructor.find(params[:id])
  end

  def update
    @instructor = Instructor.find(params[:id])
    if instructor_params[:name].nil? || instructor_params[:email].nil? || instructor_params[:name].blank? || instructor_params[:email].blank?
      flash[:danger] = 'Blank details!'
      render 'edit'
    elsif User.where("email = ? AND id NOT IN (?)", instructor_params[:email], @instructor.id).blank?
      if @instructor.update(instructor_params)
        flash[:success] = 'Updated profile!'
        redirect_to root_path
      else
        flash[:danger] = 'Cannot edit profile details!'
        render 'edit'
      end
    else
      flash[:danger] = 'Duplicate email!'
      render 'edit'
    end
  end

  private
  def instructor_params
    params.require(:instructor).permit(:name, :email, :password)
  end

end
