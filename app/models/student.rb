class Student < User
  has_many :student_enrollments
  has_many :enrollment_requests
end
