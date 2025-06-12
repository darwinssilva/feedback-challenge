require "test_helper"

class Api::FeedbacksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_feedbacks_index_url
    assert_response :success
  end
end
