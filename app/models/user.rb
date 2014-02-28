class User < ActiveRecord::Base
	attr_accessor :current_password
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

 	# Setup accessible (or protected) attributes for your model
 	attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :handle, :profile_picture, :contact_number, :current_password
 	# attr_accessible :title, :body
 	
 	validates :first_name, presence: true
 	validates :last_name, presence: true
 	validates :handle, presence: true, uniqueness: true
 	validates :email, presence: true, uniqueness: true

 	has_many :entries

 	def full_name
 		"#{first_name} #{last_name}"
 	end

 	def username
 		"@#{handle}"
 	end
end
