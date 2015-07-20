require 'test_helper'

class BlockedsControllerTest < ActionController::TestCase
  setup do
    @blocked = blockeds(:one)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:blockeds)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create blocked' do
    assert_difference('Blocked.count') do
      post :create, blocked: { status: @blocked.status }
    end

    assert_redirected_to blocked_path(assigns(:blocked))
  end

  test 'should show blocked' do
    get :show, id: @blocked
    assert_response :success
  end

  test 'should get edit' do
    get :edit, id: @blocked
    assert_response :success
  end

  test 'should update blocked' do
    patch :update, id: @blocked, blocked: { status: @blocked.status }
    assert_redirected_to blocked_path(assigns(:blocked))
  end

  test 'should destroy blocked' do
    assert_difference('Blocked.count', -1) do
      delete :destroy, id: @blocked
    end

    assert_redirected_to blockeds_path
  end
end
