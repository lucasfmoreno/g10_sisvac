require "test_helper"

class CambiosControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get cambios_edit_url
    assert_response :success
  end

  test "should get update" do
    get cambios_update_url
    assert_response :success
  end
end
