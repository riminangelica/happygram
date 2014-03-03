class User < ActiveRecord::Base
	# attr_accessor :current_password
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
  validates :profile_picture, attachment_presence: true
  

  has_attached_file :profile_picture, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  validates_attachment_content_type :profile_picture, :content_type => /\Aimage\/.*\Z/

 	has_many :entries
  has_many :comments
 	has_many :friendships
 	has_many :friends, through: :friendships,
                     conditions: { friendships: { state: 'accepted' } }

  has_many :pending_friendships, class_name: 'Friendship',
                                 foreign_key: :user_id,
                                 conditions: { state: 'pending' }
  has_many :pending_friends, through: :pending_friendships, source: :friend

  has_many :requested_friendships, class_name: 'Friendship',
                                 foreign_key: :user_id,
                                 conditions: { state: 'requested' }
  has_many :requested_friends, through: :requested_friendships, source: :friend

  has_many :blocked_friendships, class_name: 'Friendship',
                                 foreign_key: :user_id,
                                 conditions: { state: 'blocked' }
  has_many :blocked_friends, through: :blocked_friendships, source: :friend 

  has_many :accepted_friendships, class_name: 'Friendship',
                                 foreign_key: :user_id,
                                 conditions: { state: 'accepted' }
  has_many :accepted_friends, through: :accepted_friendships, source: :friend 

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

  def has_blocked?(other_user)
    blocked_friends.include?(other_user)
  end

end
