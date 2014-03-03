class Entry < ActiveRecord::Base
	attr_accessible :title, :description, :photo, :user_id, :document_attributes
	belongs_to :user
	belongs_to :document

	accepts_nested_attributes_for :document

	validates :title, presence: :true
	validates :photo, presence: :true
	validates :user_id, presence: :true	
end
