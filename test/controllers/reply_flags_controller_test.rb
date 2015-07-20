require 'test_helper'

class ReplyFlagsControllerTest < ActionController::TestCase
  setup do
    @reply_flag = reply_flags(:one)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:reply_flags)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create reply_flag' do
    assert_difference('ReplyFlag.count') do
      post :create, reply_flag: {
        reply_id: @reply_flag.reply_id,
        user_id: @reply_flag.user_id
      }
    end

    assert_redirected_to reply_flag_path(assigns(:reply_flag))
  end

  test 'should show reply_flag' do
    get :show, id: @reply_flag
    assert_response :success
  end

  test 'should get edit' do
    get :edit, id: @reply_flag
    assert_response :success
  end

  test 'should update reply_flag' do
    patch :update, id: @reply_flag, reply_flag: {
      reply_id: @reply_flag.reply_id,
      user_id: @reply_flag.user_id
    }
    assert_redirected_to reply_flag_path(assigns(:reply_flag))
  end

  test 'should destroy reply_flag' do
    assert_difference('ReplyFlag.count', -1) do
      delete :destroy, id: @reply_flag
    end

    assert_redirected_to reply_flags_path
  end
end
