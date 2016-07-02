require 'test_helper'

class Administrator::TipsControllerTest < ActionController::TestCase
  setup do
    @administrator_tip = administrator_tips(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:administrator_tips)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create administrator_tip" do
    assert_difference('Administrator::Tip.count') do
      post :create, administrator_tip: { contenido: @administrator_tip.contenido, tags: @administrator_tip.tags, titulo: @administrator_tip.titulo, usuario_id: @administrator_tip.usuario_id }
    end

    assert_redirected_to administrator_tip_path(assigns(:administrator_tip))
  end

  test "should show administrator_tip" do
    get :show, id: @administrator_tip
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @administrator_tip
    assert_response :success
  end

  test "should update administrator_tip" do
    patch :update, id: @administrator_tip, administrator_tip: { contenido: @administrator_tip.contenido, tags: @administrator_tip.tags, titulo: @administrator_tip.titulo, usuario_id: @administrator_tip.usuario_id }
    assert_redirected_to administrator_tip_path(assigns(:administrator_tip))
  end

  test "should destroy administrator_tip" do
    assert_difference('Administrator::Tip.count', -1) do
      delete :destroy, id: @administrator_tip
    end

    assert_redirected_to administrator_tips_path
  end
end
