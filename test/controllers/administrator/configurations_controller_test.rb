require 'test_helper'

class Administrator::ConfigurationsControllerTest < ActionController::TestCase
  setup do
    @administrator_configuration = administrator_configurations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:administrator_configurations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create administrator_configuration" do
    assert_difference('Administrator::Configuration.count') do
      post :create, administrator_configuration: { imagen1: @administrator_configuration.imagen1, imagen2: @administrator_configuration.imagen2, imagen3: @administrator_configuration.imagen3, imagen4: @administrator_configuration.imagen4, imagen5: @administrator_configuration.imagen5, usuario_id: @administrator_configuration.usuario_id }
    end

    assert_redirected_to administrator_configuration_path(assigns(:administrator_configuration))
  end

  test "should show administrator_configuration" do
    get :show, id: @administrator_configuration
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @administrator_configuration
    assert_response :success
  end

  test "should update administrator_configuration" do
    patch :update, id: @administrator_configuration, administrator_configuration: { imagen1: @administrator_configuration.imagen1, imagen2: @administrator_configuration.imagen2, imagen3: @administrator_configuration.imagen3, imagen4: @administrator_configuration.imagen4, imagen5: @administrator_configuration.imagen5, usuario_id: @administrator_configuration.usuario_id }
    assert_redirected_to administrator_configuration_path(assigns(:administrator_configuration))
  end

  test "should destroy administrator_configuration" do
    assert_difference('Administrator::Configuration.count', -1) do
      delete :destroy, id: @administrator_configuration
    end

    assert_redirected_to administrator_configurations_path
  end
end
