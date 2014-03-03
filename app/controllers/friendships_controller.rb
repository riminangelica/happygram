class FriendshipsController < ApplicationController
	before_filter :authenticate_user! #, only: [:new, :index]
	respond_to :html, :json

	def index
		@friendships = current_user.friendships.all
		respond_with @friendships
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
			respond_to do |format|
				if @friendship.new_record?
					format.html do
						flash[:error] = "There was a problem creating that friend request."
						redirect_to profile_path(@friend)
					end
					format.json { render json: @friendship.to_json, status: :precondition_failed }
				else
					format.html do
						flash[:success] = "Friend request sent!"
						redirect_to profile_path(@friend)
					end
					format.json { render json: @friendship.to_json }
				end
			end
		else
			flash[:error] = "Friend required"
			redirect_to root_path
		end
	end

	def edit
			@friend = User.where(handle: params[:id]).first
			100.times { puts "blah" }
			100.times { puts @friend.id }
			@friendship = current_user.friendships.where(friend_id: @friend.id).first.decorate
			100.times { puts @friendship }
	end

	def destroy
		@friendship = current_user.friendships.find(params[:id])
		if @friendship.destroy
			flash[:success] = "Friendship destroyed."
		end
		redirect_to friendships_path 
	end

end
