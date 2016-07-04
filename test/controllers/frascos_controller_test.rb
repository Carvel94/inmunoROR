require 'test_helper'

class FrascosControllerTest < ActionController::TestCase
  setup do
    @frasco = frascos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:frascos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create frasco" do
    assert_difference('Frasco.count') do
      post :create, frasco: {  }
    end

    assert_redirected_to frasco_path(assigns(:frasco))
  end

  test "should show frasco" do
    get :show, id: @frasco
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @frasco
    assert_response :success
  end

  test "should update frasco" do
    patch :update, id: @frasco, frasco: {  }
    assert_redirected_to frasco_path(assigns(:frasco))
  end

  test "should destroy frasco" do
    assert_difference('Frasco.count', -1) do
      delete :destroy, id: @frasco
    end

    assert_redirected_to frascos_path
  end
end
