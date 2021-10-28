require 'test_helper'

class Admin::GroupsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get admin_groups_show_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_groups_destroy_url
    assert_response :success
  end
end
