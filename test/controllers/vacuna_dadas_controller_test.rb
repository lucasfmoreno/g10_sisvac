require "test_helper"

class VacunaDadasControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get vacuna_dadas_new_url
    assert_response :success
  end

  test "should get create" do
    get vacuna_dadas_create_url
    assert_response :success
  end

  test "should get show" do
    get vacuna_dadas_show_url
    assert_response :success
  end
end
