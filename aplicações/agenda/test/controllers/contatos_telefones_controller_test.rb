require 'test_helper'

class ContatosTelefonesControllerTest < ActionController::TestCase
  setup do
    @contatos_telefone = contatos_telefones(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contatos_telefones)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contatos_telefone" do
    assert_difference('ContatosTelefone.count') do
      post :create, contatos_telefone: { contato_id: @contatos_telefone.contato_id, telefone_id: @contatos_telefone.telefone_id }
    end

    assert_redirected_to contatos_telefone_path(assigns(:contatos_telefone))
  end

  test "should show contatos_telefone" do
    get :show, id: @contatos_telefone
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @contatos_telefone
    assert_response :success
  end

  test "should update contatos_telefone" do
    patch :update, id: @contatos_telefone, contatos_telefone: { contato_id: @contatos_telefone.contato_id, telefone_id: @contatos_telefone.telefone_id }
    assert_redirected_to contatos_telefone_path(assigns(:contatos_telefone))
  end

  test "should destroy contatos_telefone" do
    assert_difference('ContatosTelefone.count', -1) do
      delete :destroy, id: @contatos_telefone
    end

    assert_redirected_to contatos_telefones_path
  end
end
