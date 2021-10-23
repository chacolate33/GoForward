require 'test_helper'

class Admin::PhrasesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_phrases_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_phrases_show_url
    assert_response :success
  end

end
