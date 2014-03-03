require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should have_many(:friendships)
  should have_many(:friends)

  test "a user should enter a first name" do
  	user = User.new
  	assert !user.save
  	assert !user.errors[:first_name].empty?
  end

  test "a user should enter a unique handle" do
  	user = User.new
  	user.handle = users(:happy).handle
  	assert !user.save
  	assert !user.errors[:handle].empty?
  end

  # test "a user should have a handle without spaces" do
  # 	user = User.new
  # 	user.handle = 
  # end
end
