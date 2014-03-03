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
			"You are friends with #{model.friend.first_name}."
    when 'blocked'
      "You blocked this user."
    when 'requested'
      "Awaiting confirmation."
    end
  end

  def update_action_verbiage
    case model.state
    when 'pending'
      'Delete'
    when 'requested'
      'Respond'
    when 'accepted'
      'Update'
    when 'blocked'
      'Unblock'
    end
  end
end
