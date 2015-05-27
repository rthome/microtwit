require 'test_helper'

class ChirpTest < ActiveSupport::TestCase
  def setup
    @user = users(:john)
    @chirp = @user.chirps.build(content: 'chirp chirp')
  end

  test 'should be valid' do
    assert @chirp.valid?
  end

  test 'chirp should belong to a user' do
    @chirp.user_id = nil
    assert_not @chirp.valid?
  end

  test 'chirp should have content' do
    @chirp.content = nil
    assert_not @chirp.valid?
  end

  test 'chirp content should be less than 200 characters' do
    @chirp.content = 'x' * 201
    assert_not @chirp.valid?
  end

  test 'order should be most recent first' do
    assert_equal chirps(:most_recent), Chirp.first
  end
end
