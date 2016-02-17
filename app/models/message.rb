class Message < ActiveRecord::Base
  belongs_to :student
  belongs_to :instructor
  belongs_to :course
end
