class CreateStudentEnrollments < ActiveRecord::Migration
  def change
    create_table :student_enrollments do |t|
      t.string :status, null: false
      t.string :grade, null: false
      t.timestamps null: false
    end

    add_reference :student_enrollments, :student, references: :users, index: true
    add_foreign_key :student_enrollments, :users, column: :student_id

    add_reference :student_enrollments, :course, references: :courses, index: true
    add_foreign_key :student_enrollments, :courses, column: :course_id

    # status takes values -> 'REQUESTED', 'ENROLLED', 'DROPPED'
  end
end
