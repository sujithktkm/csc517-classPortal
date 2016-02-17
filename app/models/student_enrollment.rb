class StudentEnrollment < ActiveRecord::Base
  has_many :student
  belongs_to :course
end
