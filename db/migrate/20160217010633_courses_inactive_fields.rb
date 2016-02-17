class CoursesInactiveFields < ActiveRecord::Migration
  def change
    add_column :courses, :instructor_req, :boolean, default: false
    add_column :courses, :admin_res, :boolean, default: false
  end
end
