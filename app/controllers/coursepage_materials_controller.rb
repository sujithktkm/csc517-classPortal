class CoursepageMaterialsController < ApplicationController
  def new
    @coursepage_material = CoursepageMaterial.new
  end

  def create
    @coursepage_material = CoursepageMaterial.new(materials_params)
    if @coursepage_material.save
      # session[:material_id] = @student.id
      flash[:success] = 'Added successfully'
      if @user_authenticated.type == 'Admin'
        redirect_to admins_manage_course_path
      elsif @user_authenticated.type == 'Instructor'
        redirect_to '/courses/show'
      end
    else
      flash[:danger] = 'Cannot Add. Please contact admin'
      redirect_to '/coursepage_materials/create'
    end
  end

  private
  def materials_params
    params.require(:coursepage_material).permit(:title, :description, :material_type, :course_id)
  end

end
