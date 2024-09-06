require "test_helper"

class Admin::FoodStrageAreasControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get admin_food_strage_areas_new_url
    assert_response :success
  end

  test "should get create" do
    get admin_food_strage_areas_create_url
    assert_response :success
  end

  test "should get index" do
    get admin_food_strage_areas_index_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_food_strage_areas_destroy_url
    assert_response :success
  end

  test "should get edit" do
    get admin_food_strage_areas_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_food_strage_areas_update_url
    assert_response :success
  end
end
