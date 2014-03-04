class Comment < ActiveRecord::Base
	attr_accessible :content, :user_id

  belongs_to :entry
  belongs_to :user
end
