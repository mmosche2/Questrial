require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get contact" do
    get :contact
    assert_response :success
  end

  test "should get faq" do
    get :faq
    assert_response :success
  end

  test "should get privacy" do
    get :privacy
    assert_response :success
  end

end
