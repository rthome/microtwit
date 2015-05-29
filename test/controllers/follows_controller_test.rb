require 'test_helper'

class FollowsControllerTest < ActionController::TestCase

  test 'create should redirect when not logged in' do
    assert_no_difference 'Follow.count' do
      post :create
    end
    assert_redirected_to login_url
  end

  test 'destroy should destroy when not logged in' do
    assert_no_difference 'Follow.count' do
      delete :destroy, id: follows(:one)
    end
    assert_redirected_to login_url
  end

end
