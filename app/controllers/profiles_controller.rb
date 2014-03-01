class ProfilesController < ApplicationController
  def show
  	@user = User.find_by_handle(params[:id])

  	if @user
  		@entries = @user.entries.all
  		render action: :show
  	else
  		render file: 'public/404', status: 404, formats: [:html]
  	end
  end
end
