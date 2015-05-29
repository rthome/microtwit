require 'test_helper'

class FollowpagesTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:john)
    log_in_as(@user)
  end

  test 'follow page' do
    get follows_user_path(@user)
    assert_not @user.follows.empty?
    assert_match @user.follows.count.to_s, response.body
    @user.follows.each do |user|
      assert_select 'a[href=?]', user_path(user)
    end
  end

  test 'followers page' do
    get followers_user_path(@user)
    assert_not @user.followers.empty?
    assert_match @user.followers.count.to_s, response.body
    @user.followers.each do |user|
      assert_select 'a[href=?]', user_path(user)
    end
  end

end
