require 'test_helper'

class MenuNivel0sControllerTest < ActionController::TestCase
  setup do
    @menu_nivel0 = menu_nivel0s(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:menu_nivel0s)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create menu_nivel0" do
    assert_difference('MenuNivel0.count') do
      post :create, menu_nivel0: {  }
    end

    assert_redirected_to menu_nivel0_path(assigns(:menu_nivel0))
  end

  test "should show menu_nivel0" do
    get :show, id: @menu_nivel0
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @menu_nivel0
    assert_response :success
  end

  test "should update menu_nivel0" do
    patch :update, id: @menu_nivel0, menu_nivel0: {  }
    assert_redirected_to menu_nivel0_path(assigns(:menu_nivel0))
  end

  test "should destroy menu_nivel0" do
    assert_difference('MenuNivel0.count', -1) do
      delete :destroy, id: @menu_nivel0
    end

    assert_redirected_to menu_nivel0s_path
  end
end
