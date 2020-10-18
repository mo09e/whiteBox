require 'test_helper'

class LabelsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get labels_new_url
    assert_response :success
  end

end
