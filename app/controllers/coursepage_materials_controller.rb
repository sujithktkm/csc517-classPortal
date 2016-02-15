class CoursepageMaterialsController < ApplicationController
  def new
    @coursepage_material = CoursepageMaterial.new
  end

  def create
    @coursepage_material = CoursepageMaterial.new(materials_params)
    if @coursepage_material.save
      # session[:material_id] = @student.id
      flash[:success] = "Added successfully"
      redirect_to '/courses/show'
    else
      flash[:danger] = "Cannot Add. Please contact admin"
      redirect_to '/coursepage_materials/create'
    end
  end

  private
  def materials_params
    params.require(:coursepage_material).permit(:title, :description, :material_type, :course_id)
  end

end
