require 'test_helper'

class MyPhrasesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get my_phrases_index_url
    assert_response :success
  end

end
