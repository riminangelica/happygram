require 'test_helper'

class EntryTest < ActiveSupport::TestCase
  test "that a entry requires a title" do
  	entry = Entry.new
  	assert !entry.save
  	assert !entry.errors[:title].empty?
  end

  test "that a entry has a user id" do
    entry = Entry.new
    entry.title = "Hello"
    entry.photo = "s.png"
    assert !entry.save
    assert !entry.errors[:user_id].empty?
  end
end
