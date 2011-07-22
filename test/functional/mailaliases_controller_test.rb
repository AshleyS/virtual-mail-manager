require 'test_helper'

class MailaliasesControllerTest < ActionController::TestCase
  setup do
    @mailalias = mailaliases(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mailaliases)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mailalias" do
    assert_difference('MailAlias.count') do
      post :create, :mailalias => @mailalias.attributes
    end

    assert_redirected_to mailalias_path(assigns(:mailalias))
  end

  test "should show mailalias" do
    get :show, :id => @mailalias.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @mailalias.to_param
    assert_response :success
  end

  test "should update mailalias" do
    put :update, :id => @mailalias.to_param, :mailalias => @mailalias.attributes
    assert_redirected_to mailalias_path(assigns(:mailalias))
  end

  test "should destroy mailalias" do
    assert_difference('MailAlias.count', -1) do
      delete :destroy, :id => @mailalias.to_param
    end

    assert_redirected_to mailaliases_path
  end
end
