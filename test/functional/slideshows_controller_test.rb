require 'test_helper'

class SlideshowsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get forward" do
    get :forward
    assert_response :success
  end

  test "should get backward" do
    get :backward
    assert_response :success
  end

end
