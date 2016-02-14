class AddCourseStatus < ActiveRecord::Migration
  def change
    add_column :courses, :status, :boolean, :default => false
  end
end
