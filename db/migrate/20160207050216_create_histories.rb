class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.string :role, null: false
      t.string :grade
      t.timestamps null: false
    end

    add_reference :histories, :user, references: :users, index: true
    add_foreign_key :histories, :users, column: :user_id

    add_reference :histories, :course, references: :courses, index: true
    add_foreign_key :histories, :courses, column: :course_id

    # role can only be instructor -> TAUGHT or student -> TAKEN
  end
end
