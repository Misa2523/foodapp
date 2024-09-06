require "test_helper"

class Public::HomeFoodsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_home_foods_new_url
    assert_response :success
  end

  test "should get create" do
    get public_home_foods_create_url
    assert_response :success
  end

  test "should get index" do
    get public_home_foods_index_url
    assert_response :success
  end

  test "should get edit" do
    get public_home_foods_edit_url
    assert_response :success
  end

  test "should get update" do
    get public_home_foods_update_url
    assert_response :success
  end

  test "should get destroy" do
    get public_home_foods_destroy_url
    assert_response :success
  end
end
