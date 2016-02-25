class CoursepageMaterialsController < ApplicationController
  before_action :instructor_admin_access, only: [:new, :create]
  def new
    @coursepage_material = CoursepageMaterial.new
  end

  def create

    if materials_params[:title].nil? || materials_params[:material_type].nil? || materials_params[:description].nil? || materials_params[:title].blank? || materials_params[:material_type].blank? || materials_params[:description].blank?
      flash[:danger] = 'Cannot be blank!'
      redirect_to '/coursepage_materials/new'
    else
      @coursepage_material = CoursepageMaterial.new(materials_params)
      if @coursepage_material.save
        # session[:material_id] = @student.id
        flash[:success] = 'Added successfully'
        if @user_authenticated.type == 'Admin'
          redirect_to admins_manage_course_path
        elsif @user_authenticated.type == 'Instructor'
          redirect_to course_path(:id=>@coursepage_material.course_id)

        end
      else
        flash[:danger] = 'Cannot Add. Please contact admin'
        redirect_to '/coursepage_materials/new'
      end
    end
  end

  private
  def materials_params
    params.require(:coursepage_material).permit(:title, :description, :material_type, :course_id)
  end

end
