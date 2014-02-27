class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

 	# Setup accessible (or protected) attributes for your model
 	attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :handle, :profile_picture, :contact_number
 	# attr_accessible :title, :body

end
