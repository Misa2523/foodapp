require "test_helper"

class Pubic::CustomersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pubic_customers_index_url
    assert_response :success
  end

  test "should get posts_index" do
    get pubic_customers_posts_index_url
    assert_response :success
  end

  test "should get show" do
    get pubic_customers_show_url
    assert_response :success
  end

  test "should get edit" do
    get pubic_customers_edit_url
    assert_response :success
  end

  test "should get update" do
    get pubic_customers_update_url
    assert_response :success
  end

  test "should get check" do
    get pubic_customers_check_url
    assert_response :success
  end

  test "should get out" do
    get pubic_customers_out_url
    assert_response :success
  end
end
