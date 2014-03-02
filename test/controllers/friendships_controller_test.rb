require 'test_helper'

class FriendshipsControllerTest < ActionController::TestCase
  context "#new" do
  	context "when not logged in" do
  		should "redirect to the login page" do
  			get :new
  			assert_response :redirect
  		end
  	end

  	context "when logged in" do
  		setup do
  			sign_in users(:rimi)

  		end

  		should "get new and return success" do
  			get :new
  			assert_response :redirect
  		end
  	end
  end
end
