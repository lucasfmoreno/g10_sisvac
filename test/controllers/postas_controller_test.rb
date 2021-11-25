require "test_helper"

class PostasControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get postas_edit_url
    assert_response :success
  end
end
