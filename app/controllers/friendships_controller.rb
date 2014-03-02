class FriendshipsController < ApplicationController
	before_filter :authenticate_user!, only: [:new]
	
	def new
		if params[:friend_id]
			@friend = User.where(handle: params[:friend_id]).first
			raise ActiveRecord::RecordNotFound if @friend.nil?
			@friendship = current_user.friendships.new(friend: @friend)
		else
			flash[:error] = "Friend required"
		end
	rescue ActiveRecord::RecordNotFound
		render file: 'public/404', status: :not_found
	end
end
