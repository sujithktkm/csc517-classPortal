class Course < ActiveRecord::Base
  has_many :course_instructors
  has_many :instructors
  has_many :coursepage_materials
  has_many :histories

  has_many :student_enrollments

  validate :DateChecker
  def DateChecker
    if start_date > end_date || start_date < Date.today
      errors.add("Dates are not selected properly")
    end
  end

end
