require 'test_helper'

class DislikeCountRepliesControllerTest < ActionController::TestCase
  setup do
    @dislike_count_reply = dislike_count_replies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dislike_count_replies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dislike_count_reply" do
    assert_difference('DislikeCountReply.count') do
      post :create, dislike_count_reply: { reply_id: @dislike_count_reply.reply_id, user_id: @dislike_count_reply.user_id }
    end

    assert_redirected_to dislike_count_reply_path(assigns(:dislike_count_reply))
  end

  test "should show dislike_count_reply" do
    get :show, id: @dislike_count_reply
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dislike_count_reply
    assert_response :success
  end

  test "should update dislike_count_reply" do
    patch :update, id: @dislike_count_reply, dislike_count_reply: { reply_id: @dislike_count_reply.reply_id, user_id: @dislike_count_reply.user_id }
    assert_redirected_to dislike_count_reply_path(assigns(:dislike_count_reply))
  end

  test "should destroy dislike_count_reply" do
    assert_difference('DislikeCountReply.count', -1) do
      delete :destroy, id: @dislike_count_reply
    end

    assert_redirected_to dislike_count_replies_path
  end
end
