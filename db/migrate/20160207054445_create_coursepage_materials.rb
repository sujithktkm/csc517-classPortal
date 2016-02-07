class CreateCoursepageMaterials < ActiveRecord::Migration
  def change
    create_table :coursepage_materials do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.string :type, null: false
      t.timestamps null: false
    end

    add_reference :coursepage_materials, :course, references: :courses, index: true
    add_foreign_key :coursepage_materials, :courses, column: :course_id

    # type takes 'NOTIFICATION', 'DEADLINE'
  end
end
