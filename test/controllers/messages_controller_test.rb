require 'test_helper'

class MessagesControllerTest < ActionController::TestCase
  test "should get mark_as_read" do
    get :mark_as_read
    assert_response :success
  end

end
