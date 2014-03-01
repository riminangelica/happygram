require 'test_helper'

class EntriesControllerTest < ActionController::TestCase
  setup do
    @entry = entries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:entries)
  end

  test "should be redirected when not logged in" do
    get :new
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should render the feed page when logged in" do
    sign_in users(:rimi)
    get :index
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should be logged in to post an entry" do
    post :create, entry: { title: "Hello", description: "blah", photo: "s.png" }
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should create entry when logged in" do
    sign_in users(:rimi)

    assert_difference('Entry.count') do
      post :create, entry: { description: @entry.description, photo: @entry.photo, title: @entry.title }
    end

    assert_redirected_to entry_path(assigns(:entry))
  end

  test "should show entry" do
    get :show, id: @entry
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @entry
    assert_response :success
  end

  test "should update entry" do
    patch :update, id: @entry, entry: { description: @entry.description, photo: @entry.photo, title: @entry.title }
    assert_redirected_to entry_path(assigns(:entry))
  end

  test "should destroy entry" do
    assert_difference('Entry.count', -1) do
      delete :destroy, id: @entry
    end

    assert_redirected_to entries_path
  end
end
