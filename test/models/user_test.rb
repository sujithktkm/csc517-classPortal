require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'Create new user' do
    user = User.new do |u|
      u.name = 'name'
      u.email = 'email@email.com'
      u.password = 'password'
      u.type = 'Student'
    end

    begin
      user.save!
      assert user.id
    rescue
      fail 'New user created!'
    end
  end

  test 'Create an instructor rather than a user with type' do
    user = Instructor.create do |i|
      i.name = 'name'
      i.email = 'email@email.com'
      i.password = 'password'
    end
    assert user.id
    assert_equal 'Instructor', user.type
  end

  test 'Fields not nil' do
    user = User.new do |u|
      u.name = nil
      u.email = nil
      u.password = nil
      u.type = 'Admin'
    end

    begin
      user.save!
      fail 'User save failed!'
    rescue
      assert_not user.id
    end
  end

  test 'Unique email' do
    Instructor.create do |i|
      i.name = 'name'
      i.email = 'email@email.com'
      i.password = 'password'
    end

    # Attempt to create the second user
    begin
      Student.create do |s|
        s.name = 'name'
        s.email = 'email@email.com'
        s.password = 'password'
      end
      fail 'Duplicate email!'
    rescue
# ignored
    end
  end
end