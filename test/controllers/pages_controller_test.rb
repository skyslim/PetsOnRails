require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get contactus" do
    get :contactus
    assert_response :success
  end

  test "should get aboutus" do
    get :aboutus
    assert_response :success
  end

  test "should get petguide" do
    get :petguide
    assert_response :success
  end

  test "should get admin" do
    get :admin
    assert_response :success
  end

end
