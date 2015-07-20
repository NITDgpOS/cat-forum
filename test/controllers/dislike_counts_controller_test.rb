require 'test_helper'

class DislikeCountsControllerTest < ActionController::TestCase
  setup do
    @dislike_count = dislike_counts(:one)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:dislike_counts)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create dislike_count' do
    assert_difference('DislikeCount.count') do
      post :create, dislike_count: {
        new_thread_id: @dislike_count.new_thread_id,
        user_id: @dislike_count.user_id
      }
    end

    assert_redirected_to dislike_count_path(assigns(:dislike_count))
  end

  test 'should show dislike_count' do
    get :show, id: @dislike_count
    assert_response :success
  end

  test 'should get edit' do
    get :edit, id: @dislike_count
    assert_response :success
  end

  test 'should update dislike_count' do
    patch :update, id: @dislike_count, dislike_count: {
      new_thread_id: @dislike_count.new_thread_id,
      user_id: @dislike_count.user_id
    }
    assert_redirected_to dislike_count_path(assigns(:dislike_count))
  end

  test 'should destroy dislike_count' do
    assert_difference('DislikeCount.count', -1) do
      delete :destroy, id: @dislike_count
    end

    assert_redirected_to dislike_counts_path
  end
end
