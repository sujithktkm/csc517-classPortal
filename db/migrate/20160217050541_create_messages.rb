class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :role, null: false
      t.string :content, null: false
      t.timestamps null: false
    end

    add_reference :messages, :student, references: :users, index: true
    add_foreign_key :messages, :users, column: :student_id

    add_reference :messages, :instructor, references: :users, index: true
    add_foreign_key :messages, :users, column: :instructor_id

    add_reference :messages, :course, references: :courses, index: true
    add_foreign_key :messages, :courses, column: :course_id

  end
end
