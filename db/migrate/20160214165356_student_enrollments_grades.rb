class StudentEnrollmentsGrades < ActiveRecord::Migration
  def change
    change_column :student_enrollments, :grade, :string, default: '0', null: true
  end
end
