class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :coursenumber, null: false
      t.string :title, null: false
      t.string :description, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.timestamps null: false
    end
  end
end