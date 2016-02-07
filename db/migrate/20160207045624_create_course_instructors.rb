class CreateCourseInstructors < ActiveRecord::Migration
  def change
    create_table :course_instructors do |t|
      t.boolean :status, null: false
      t.timestamps null: false
    end

    add_reference :course_instructors, :course, references: :courses, index: true
    add_foreign_key :course_instructors, :courses, column: :course_id

    add_reference :course_instructors, :instructor, references: :users, index: true
    add_foreign_key :course_instructors, :users, column: :instructor_id

    # status can only be true -> ACTIVE and false -> INACTIVE
  end
end
