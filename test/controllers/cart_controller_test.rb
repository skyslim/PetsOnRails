require 'test_helper'

class CartControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get add" do
    get :add
    assert_response :success
  end

  test "should get remove" do
    get :remove
    assert_response :success
  end

  test "should get change" do
    get :change
    assert_response :success
  end

  test "should get empty" do
    get :empty
    assert_response :success
  end

end
