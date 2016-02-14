class Course < ActiveRecord::Base
  has_many :course_instructors
  has_many :instructors
  has_many :coursepage_materials
end
