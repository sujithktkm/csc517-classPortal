class CoursesAddFields < ActiveRecord::Migration
  def change
    add_reference :courses, :instructor, references: :users, index: true
    add_foreign_key :courses, :users, column: :instructor_id
  end
end
