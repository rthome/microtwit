require 'test_helper'

class FollowTest < ActiveSupport::TestCase

  def setup
    @follow = Follow.new(follower_id: 1, followed_id: 2)
  end

  test 'should be valid' do
    assert @follow.valid?
  end

  test 'should require a follower id' do
    @follow.follower_id = nil
    assert_not @follow.valid?
  end

  test 'should require id of followed' do
    @follow.followed_id = nil
    assert_not @follow.valid?
  end

end
