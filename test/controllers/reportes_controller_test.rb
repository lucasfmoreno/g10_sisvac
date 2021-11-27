require "test_helper"

class ReportesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get reportes_show_url
    assert_response :success
  end
end
