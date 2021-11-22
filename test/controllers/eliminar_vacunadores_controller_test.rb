require "test_helper"

class EliminarVacunadoresControllerTest < ActionDispatch::IntegrationTest
  test "should get delete" do
    get eliminar_vacunadores_delete_url
    assert_response :success
  end
end
