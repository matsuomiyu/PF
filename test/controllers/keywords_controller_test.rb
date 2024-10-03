require "test_helper"

class KeywordsControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get keywords_search_url
    assert_response :success
  end
end
