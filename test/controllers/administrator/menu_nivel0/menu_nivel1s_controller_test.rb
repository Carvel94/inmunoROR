require 'test_helper'

class Administrator::MenuNivel0::MenuNivel1sControllerTest < ActionController::TestCase
  setup do
    @administrator_menu_nivel0_menu_nivel1 = administrator_menu_nivel0_menu_nivel1s(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:administrator_menu_nivel0_menu_nivel1s)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create administrator_menu_nivel0_menu_nivel1" do
    assert_difference('Administrator::MenuNivel0::MenuNivel1.count') do
      post :create, administrator_menu_nivel0_menu_nivel1: {  }
    end

    assert_redirected_to administrator_menu_nivel0_menu_nivel1_path(assigns(:administrator_menu_nivel0_menu_nivel1))
  end

  test "should show administrator_menu_nivel0_menu_nivel1" do
    get :show, id: @administrator_menu_nivel0_menu_nivel1
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @administrator_menu_nivel0_menu_nivel1
    assert_response :success
  end

  test "should update administrator_menu_nivel0_menu_nivel1" do
    patch :update, id: @administrator_menu_nivel0_menu_nivel1, administrator_menu_nivel0_menu_nivel1: {  }
    assert_redirected_to administrator_menu_nivel0_menu_nivel1_path(assigns(:administrator_menu_nivel0_menu_nivel1))
  end

  test "should destroy administrator_menu_nivel0_menu_nivel1" do
    assert_difference('Administrator::MenuNivel0::MenuNivel1.count', -1) do
      delete :destroy, id: @administrator_menu_nivel0_menu_nivel1
    end

    assert_redirected_to administrator_menu_nivel0_menu_nivel1s_path
  end
end
