# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Admin.create name: 'admin', email: 'admin@csc517.com', password: 'csc517', deletable: false
Student.create name: 'anurag', email: 'anurag@gmail.com', password: 'abcd'
Instructor.create name: 'efg', email: 'efg@gmail.com', password: 'efg'
Course.create coursenumber: '517', title: 'OODD', description: 'Object Oriented Design Development', start_date: '2016-02-08', end_date: '2016-05-06'
CourseInstructor.create status: true, course_id: 1, instructor_id: 8