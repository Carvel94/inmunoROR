require 'test_helper'

class Administrator::MenuNivel0sControllerTest < ActionController::TestCase
  setup do
    @administrator_menu_nivel0 = administrator_menu_nivel0s(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:administrator_menu_nivel0s)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create administrator_menu_nivel0" do
    assert_difference('Administrator::MenuNivel0.count') do
      post :create, administrator_menu_nivel0: {  }
    end

    assert_redirected_to administrator_menu_nivel0_path(assigns(:administrator_menu_nivel0))
  end

  test "should show administrator_menu_nivel0" do
    get :show, id: @administrator_menu_nivel0
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @administrator_menu_nivel0
    assert_response :success
  end

  test "should update administrator_menu_nivel0" do
    patch :update, id: @administrator_menu_nivel0, administrator_menu_nivel0: {  }
    assert_redirected_to administrator_menu_nivel0_path(assigns(:administrator_menu_nivel0))
  end

  test "should destroy administrator_menu_nivel0" do
    assert_difference('Administrator::MenuNivel0.count', -1) do
      delete :destroy, id: @administrator_menu_nivel0
    end

    assert_redirected_to administrator_menu_nivel0s_path
  end
end
