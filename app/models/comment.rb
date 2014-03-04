class Comment < ActiveRecord::Base
	attr_accessible :content, :user_id, :entry_id 
	
	belongs_to :entry

	validates :content, presence: true
	validates :user_id, presence: true
	validates :entry_id, presence: true

	def to_s
		"#{user_id}"
	end
end
