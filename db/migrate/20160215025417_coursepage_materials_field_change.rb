class CoursepageMaterialsFieldChange < ActiveRecord::Migration
  def change
    rename_column :coursepage_materials, :type, :material_type
  end
end
