class CoursepageMaterial < ActiveRecord::Base
  self.inheritance_column = nil
  belongs_to :course
end
