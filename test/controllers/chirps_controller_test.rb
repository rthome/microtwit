require 'test_helper'

class ChirpsControllerTest < ActionController::TestCase
  def setup
    @chirp = chirps(:one)
  end

  test 'should redirect create when not logged in' do
    assert_no_difference 'Chirp.count' do
      post :create, chirp: { content: 'Lorem ipsum'}
    end
    assert_redirected_to login_url
  end

  test 'should redirect destroy when not logged in' do
    assert_no_difference 'Chirp.count' do
      post :create, chirp: { content: 'Lorem ipsum'}
    end
    assert_redirected_to login_url
  end
end
