require "test_helper"

class PorductsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get porducts_show_url
    assert_response :success
  end

  test "should get index" do
    get porducts_index_url
    assert_response :success
  end
end
