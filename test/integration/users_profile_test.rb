require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:john)
    log_in_as(@user)
  end

  test 'visit user profile' do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'h1', text: @user.name
    assert_select 'h1>a>img.gravatar'
    assert_match @user.chirps.count.to_s, response.body
    assert_select 'div.pagination'
    @user.chirps.paginate(page: 1).each do |chirp|
      assert_match chirp.content, response.body
    end
  end
end
