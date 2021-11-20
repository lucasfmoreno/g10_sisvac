require "test_helper"

class VacunadoresControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get vacunadores_new_url
    assert_response :success
  end

  test "should get create" do
    get vacunadores_create_url
    assert_response :success
  end
end
