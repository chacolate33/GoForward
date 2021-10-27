require 'test_helper'

class Admin::FavoritesControllerTest < ActionDispatch::IntegrationTest
  test "should get followers" do
    get admin_favorites_followers_url
    assert_response :success
  end

  test "should get followings" do
    get admin_favorites_followings_url
    assert_response :success
  end

end
