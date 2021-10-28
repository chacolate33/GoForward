require 'test_helper'

class PhrasesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get phrases_show_url
    assert_response :success
  end

  test "should get destroy" do
    get phrases_destroy_url
    assert_response :success
  end

  test "should get edit" do
    get phrases_edit_url
    assert_response :success
  end

  test "should get update" do
    get phrases_update_url
    assert_response :success
  end

  test "should get index" do
    get phrases_index_url
    assert_response :success
  end

  test "should get create" do
    get phrases_create_url
    assert_response :success
  end
end
