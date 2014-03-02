class FriendshipsController < ApplicationController
	before_filter :authenticate_user!, only: [:new]
	
	def new
		if params[:friend_id]
			@friend = User.where(handle: params[:friend_id]).first
			@friendship = current_user.friendships.new(friend: @friend)
		else
			flash[:error] = "Friend required"
		end
	rescue ActiveRecord::RecordNotFound
		render file: 'public/404', status: :not_found
	end

	def create
		if params[:friendship] && params[:friendship].has_key?(:friend_id)
			@friend = User.where(handle: params[:friendship][:friend_id]).first
			@friendship = current_user.friendships.new(friend: @friend)
			if @friendship.save
				flash[:success] = "You are now friends with #{@friend.full_name}."
			else
				flash[:error] = "There was a problem."
			end
			redirect_to profile_path(@friend.handle)
		else
			flash[:error] = "Friend required"
			redirect_to root_path
		end
	end

end
