class UserNotifier < ActionMailer::Base
  default from: "from@example.com"

  def friend_requested(friendship_id)
  	friendship = Friendship.find(friendship_id)

  	@user = friendship.user
  	@friend = friendship.friend

  	mail to: @friend.email,
  			 subject: "#{@user.first_name} wants to be friends with you on happygram!"
  end

  def friend_request_accepted(friendship_id)
  	friendship = Friendship.find(friendship_id)

  	@user = friendship.user
  	@friend = friendship.friend

  	mail to: @user.email,
  			 subject: "#{@friend.first_name} has accepted your friend request."
  end
end
