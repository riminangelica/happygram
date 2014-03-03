class FriendshipsController < ApplicationController
	before_filter :authenticate_user! #, only: [:new, :index]
	respond_to :html, :json

	def index
		@friendships = FriendshipDecorator.decorate_collection(friendship_association.all)
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

	def block
		@friendship = current_user.friendships.find(params[:id])
		if @friendship.block!
			flash[:success] = "You have blocked #{@friendship.friend.first_name}."
		else
			flash[:error] = "That friendship could not be blocked."
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
			@friendship = current_user.friendships.where(friend_id: @friend.id).first.decorate
	end

	def destroy
		@friendship = current_user.friendships.find(params[:id])
		if @friendship.destroy
			flash[:success] = "Friendship destroyed."
		end
		redirect_to friendships_path 
	end

	private
	def friendship_association
		case params[:list]
		when nil
			current_user.friendships
		when 'blocked'
			current_user.blocked_friendships
		when 'pending'
			current_user.pending_friendships
		when 'accepted'
			current_user.accepted_friendships
		when 'requested'
			current_user.requested_friendships
		end
	end

end
