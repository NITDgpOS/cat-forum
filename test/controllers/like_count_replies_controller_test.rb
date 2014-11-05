require 'test_helper'

class LikeCountRepliesControllerTest < ActionController::TestCase
  setup do
    @like_count_reply = like_count_replies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:like_count_replies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create like_count_reply" do
    assert_difference('LikeCountReply.count') do
      post :create, like_count_reply: { reply_id: @like_count_reply.reply_id, user_id: @like_count_reply.user_id }
    end

    assert_redirected_to like_count_reply_path(assigns(:like_count_reply))
  end

  test "should show like_count_reply" do
    get :show, id: @like_count_reply
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @like_count_reply
    assert_response :success
  end

  test "should update like_count_reply" do
    patch :update, id: @like_count_reply, like_count_reply: { reply_id: @like_count_reply.reply_id, user_id: @like_count_reply.user_id }
    assert_redirected_to like_count_reply_path(assigns(:like_count_reply))
  end

  test "should destroy like_count_reply" do
    assert_difference('LikeCountReply.count', -1) do
      delete :destroy, id: @like_count_reply
    end

    assert_redirected_to like_count_replies_path
  end
end
