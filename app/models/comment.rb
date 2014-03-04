class Comment < ActiveRecord::Base
	attr_accessible :content, :user_id, :entry_id, :commentable_id, :commentable_type

  belongs_to :entry
  belongs_to :user
	belongs_to :commentable, :polymorphic => true
end
