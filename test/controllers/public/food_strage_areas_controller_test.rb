require "test_helper"

class Public::FoodStrageAreasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_food_strage_areas_index_url
    assert_response :success
  end
end
