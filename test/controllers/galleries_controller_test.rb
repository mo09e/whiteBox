require 'test_helper'

class GalleriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get galleries_index_url
    assert_response :success
  end

  test "should get new" do
    get galleries_new_url
    assert_response :success
  end

  test "should get show" do
    get galleries_show_url
    assert_response :success
  end

  test "should get edit" do
    get galleries_edit_url
    assert_response :success
  end

  test "should get _form" do
    get galleries__form_url
    assert_response :success
  end

end
