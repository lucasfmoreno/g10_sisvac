require "test_helper"

class InvitadosControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get invitados_new_url
    assert_response :success
  end

  test "should get show" do
    get invitados_show_url
    assert_response :success
  end
end
