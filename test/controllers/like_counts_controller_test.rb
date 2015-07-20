require 'test_helper'

class LikeCountsControllerTest < ActionController::TestCase
  setup do
    @like_count = like_counts(:one)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:like_counts)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create like_count' do
    assert_difference('LikeCount.count') do
      post :create, like_count: {
        new_thread_id: @like_count.new_thread_id,
        user_id: @like_count.user_id
      }
    end

    assert_redirected_to like_count_path(assigns(:like_count))
  end

  test 'should show like_count' do
    get :show, id: @like_count
    assert_response :success
  end

  test 'should get edit' do
    get :edit, id: @like_count
    assert_response :success
  end

  test 'should update like_count' do
    patch :update, id: @like_count, like_count: {
      new_thread_id: @like_count.new_thread_id,
      user_id: @like_count.user_id
    }
    assert_redirected_to like_count_path(assigns(:like_count))
  end

  test 'should destroy like_count' do
    assert_difference('LikeCount.count', -1) do
      delete :destroy, id: @like_count
    end

    assert_redirected_to like_counts_path
  end
end
