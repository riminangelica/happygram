class FriendshipDecorator < Draper::Decorator
  decorates :friendship
  delegate_all
  
  def friendship_state
  	model.state.titleize
  end

  def sub_message
  	case model.state
		when 'pending'
			"Friend request pending."
		when 'accepted'
			"You are friends #{model.friend.first_name}."
    end
  end
end
