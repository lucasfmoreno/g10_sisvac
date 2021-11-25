require "test_helper"

class VacunatoriosControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get vacunatorios_new_url
    assert_response :success
  end

  test "should get edit" do
    get vacunatorios_edit_url
    assert_response :success
  end
end
