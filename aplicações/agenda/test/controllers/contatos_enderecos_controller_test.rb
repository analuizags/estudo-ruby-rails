require 'test_helper'

class ContatosEnderecosControllerTest < ActionController::TestCase
  setup do
    @contatos_endereco = contatos_enderecos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contatos_enderecos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contatos_endereco" do
    assert_difference('ContatosEndereco.count') do
      post :create, contatos_endereco: { contato_id: @contatos_endereco.contato_id, endereco_id: @contatos_endereco.endereco_id }
    end

    assert_redirected_to contatos_endereco_path(assigns(:contatos_endereco))
  end

  test "should show contatos_endereco" do
    get :show, id: @contatos_endereco
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @contatos_endereco
    assert_response :success
  end

  test "should update contatos_endereco" do
    patch :update, id: @contatos_endereco, contatos_endereco: { contato_id: @contatos_endereco.contato_id, endereco_id: @contatos_endereco.endereco_id }
    assert_redirected_to contatos_endereco_path(assigns(:contatos_endereco))
  end

  test "should destroy contatos_endereco" do
    assert_difference('ContatosEndereco.count', -1) do
      delete :destroy, id: @contatos_endereco
    end

    assert_redirected_to contatos_enderecos_path
  end
end
