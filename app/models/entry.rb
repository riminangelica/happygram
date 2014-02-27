class Entry < ActiveRecord::Base
	attr_accessible :title, :description, :photo, :user_id
end
