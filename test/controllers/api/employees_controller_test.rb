require "test_helper"

class Api::EmployeesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_employees_index_url
    assert_response :success
  end

  test "should get show" do
    get api_employees_show_url
    assert_response :success
  end
end
