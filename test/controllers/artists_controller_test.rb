require 'test_helper'

class ArtistsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get artists_index_url
    assert_response :success
  end

  test "should get new" do
    get artists_new_url
    assert_response :success
  end

  test "should get show" do
    get artists_show_url
    assert_response :success
  end

  test "should get edit" do
    get artists_edit_url
    assert_response :success
  end

  test "should get _form" do
    get artists__form_url
    assert_response :success
  end

end
