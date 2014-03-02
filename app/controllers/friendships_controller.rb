class FriendshipsController < ApplicationController
	before_filter :authenticate_user!, only: [:new, :index]
	
	def index
		@friendships = current_user.friendships.all
	end

	def accept
		@friendship = current_user.friendships.find(params[:id])
		if @friendship.accept!
			flash[:success] = "You are now friends with #{@friendship.friend.first_name}!"
		else
			flash[:error] = "That friendship could not be accepted. :("
		end
		redirect_to friendships_path
	end

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
			@friendship = Friendship.request(current_user, @friend)
			if @friendship.new_record?
				flash[:error] = "There was a problem creating that friend request."
			else
				flash[:success] = "Friend request sent!"
			end
			redirect_to profile_path(@friend)
		else
			flash[:error] = "Friend required"
			redirect_to root_path
		end
	end

	def edit
		@friendship = current_user.friendships.find(params[:id])
		@friend = @friendship.friend
	end

	def destroy
		@friendship = current_user.friendships.find(params[:id])
		if @friendship.destroy
			flash[:success] = "Friendship destroyed."
		end
		redirect_to friendships_path 
	end

end
