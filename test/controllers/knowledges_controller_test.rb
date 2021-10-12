require 'test_helper'

class KnowledgesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get knowledges_new_url
    assert_response :success
  end

  test "should get create" do
    get knowledges_create_url
    assert_response :success
  end

  test "should get edit" do
    get knowledges_edit_url
    assert_response :success
  end

  test "should get update" do
    get knowledges_update_url
    assert_response :success
  end

  test "should get show" do
    get knowledges_show_url
    assert_response :success
  end

  test "should get destroy" do
    get knowledges_destroy_url
    assert_response :success
  end

end
