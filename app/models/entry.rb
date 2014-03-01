class Entry < ActiveRecord::Base
	attr_accessible :title, :description, :photo, :user_id
	belongs_to :user

	validates :title, presence: :true
	validates :photo, presence: :true
	validates :user_id, presence: :true
	
end
