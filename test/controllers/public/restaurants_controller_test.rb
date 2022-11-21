require "test_helper"

class Public::RestaurantsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_restaurants_show_url
    assert_response :success
  end
end
