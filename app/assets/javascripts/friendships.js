$(document).ready(function() {

	$('#add-friendship').click(function(event) {
		event.preventDefault();
		var addFriendshipBtn = $(this);
		$.ajax({
			url: Routes.friendships_path({friendship: { friend_id: addFriendshipBtn.data('friendId') }}),
			dataType: 'json',
			type: 'POST',
			success: function(e) {
				addFriendshipBtn.hide();
				$('#friend-status').html("<a href='#' class='btn btn-success'>Friendship Requested</a>");
			}
		});
	});

});