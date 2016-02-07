class CreateEnrollmentRequests < ActiveRecord::Migration
  def change
    create_table :enrollment_requests do |t|
      t.boolean :finished, null: false
      t.timestamps null: false
    end

    add_reference :enrollment_requests, :student, references: :users, index: true
    add_foreign_key :enrollment_requests, :users, column: :student_id

    add_reference :enrollment_requests, :course, references: :courses, index: true
    add_foreign_key :enrollment_requests, :courses, column: :course_id
  end
end
