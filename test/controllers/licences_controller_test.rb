require 'test_helper'

class LicencesControllerTest < ActionController::TestCase
  test "should get rails" do
    get :rails
    assert_response :success
  end

  test "should get g" do
    get :g
    assert_response :success
  end

  test "should get controller" do
    get :controller
    assert_response :success
  end

  test "should get api/v1/licences" do
    get :api/v1/licences
    assert_response :success
  end

end
