# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Admin.create name: 'admins', email: 'admins@csc517.com', password: 'csc517', deletable: false
Student.create name: 'anurag', email: 'anurag@gmail.com', password: 'abcd'
Admin.create name: 'vijay', email: 'vijay@csc517.com', password: 'csc517', deletable: false