require 'test_helper'

class NewThreadFlagsControllerTest < ActionController::TestCase
  setup do
    @new_thread_flag = new_thread_flags(:one)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:new_thread_flags)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create new_thread_flag' do
    assert_difference('NewThreadFlag.count') do
      post :create, new_thread_flag: {
        new_thread_id: @new_thread_flag.new_thread_id,
        user_id: @new_thread_flag.user_id
      }
    end

    assert_redirected_to new_thread_flag_path(assigns(:new_thread_flag))
  end

  test 'should show new_thread_flag' do
    get :show, id: @new_thread_flag
    assert_response :success
  end

  test 'should get edit' do
    get :edit, id: @new_thread_flag
    assert_response :success
  end

  test 'should update new_thread_flag' do
    patch :update, id: @new_thread_flag, new_thread_flag: {
      new_thread_id: @new_thread_flag.new_thread_id,
      user_id: @new_thread_flag.user_id
    }
    assert_redirected_to new_thread_flag_path(assigns(:new_thread_flag))
  end

  test 'should destroy new_thread_flag' do
    assert_difference('NewThreadFlag.count', -1) do
      delete :destroy, id: @new_thread_flag
    end

    assert_redirected_to new_thread_flags_path
  end
end
