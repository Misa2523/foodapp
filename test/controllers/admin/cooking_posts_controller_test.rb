require "test_helper"

class Admin::CookingPostsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_cooking_posts_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_cooking_posts_show_url
    assert_response :success
  end
end
