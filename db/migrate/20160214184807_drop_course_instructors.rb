class DropCourseInstructors < ActiveRecord::Migration
  def change
    drop_table :course_instructors
  end
end
