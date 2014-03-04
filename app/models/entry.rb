class Entry < ActiveRecord::Base
	attr_accessible :title, :description, :photo, :user_id
	belongs_to :user
	
	validates :title, presence: :true
	validates :user_id, presence: :true	
	validates :photo, attachment_presence: true
	#, content_type: { content_type: ["image/jpg", "image/gif", "image/png"] }
	# validates_with AttachmentPresenceValidator, :attributes => :photo

	# validates_with AttachmentContentTypeValidator, :attributes => :photo

	has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
end
