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
 	validates :handle, presence: true, uniqueness: true, format: {
    with: /\A[a-zA-Z0-9\-\_]+\Z/,
    message: "must be formatted correctly."
  }
 	validates :email, presence: true, uniqueness: true


 	has_many :entries
 	has_many :friendships
 	has_many :friends, through: :friendships

 	def full_name
 		"#{first_name} #{last_name}"
 	end

 	def username
 		"@#{handle}"
 	end

	def to_param
		handle
	end

 	def gravatar_url
 		stripped_email = email.strip
 		downcased_email = stripped_email.downcase
 		hash = Digest::MD5.hexdigest(downcased_email)

 		"http://gravatar.com/avatar/#{hash}"
 	end
end
