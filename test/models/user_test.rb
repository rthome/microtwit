require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Test User", email: "test@example.com", password: "secret", password_confirmation: "secret")
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'name should be present' do
    @user.name = ""
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = "     "
    assert_not @user.valid?
  end

  test 'email validation should accept valid addresses' do
    valid_addresses = %w[test@example.com test@example test-user@example.co.uk]
    valid_addresses.each do |address|
      @user.email = address
      assert @user.valid?, "#{address.inspect} should be valid"
    end
  end

  test 'email validation should reject invalid addresses' do
    invalid_addresses = %w[user.example.com user@ @user @]
    invalid_addresses.each do |address|
      @user.email = address
      assert_not @user.valid?, "#{address.inspect} should be invalid"
    end
  end

  test 'email addresses should be unique' do
    dup_user = @user.dup
    dup_user.email = @user.email.upcase
    @user.save
    assert_not dup_user.valid?
  end

  test 'authenticated? should return false for a user with nil digest' do
    assert_not @user.authenticated?('')
  end

  test 'associated chirps should be destroyed' do
    @user.save
    @user.chirps.create!(content: 'chirpy chirp')
    assert_difference 'Chirp.count', -1 do
      @user.destroy
    end
  end

  test 'should follow and unfollow other user' do
    john = users(:john)
    harrison = users(:harrison)
    assert_not john.following?(harrison)
    assert_not harrison.followers.include?(john)
    john.follow(harrison)
    assert john.following?(harrison)
    assert harrison.followers.include?(john)
    john.unfollow(harrison)
    assert_not john.following?(harrison)
    assert_not harrison.followers.include?(john)
  end

  test 'feed should have the correct chirps in it' do
    john = users(:john)
    mary = users(:mary) # followed by john
    jack = users(:jack) # not followed by john
    mary.chirps.each do |chirp|
      assert john.feed.include?(chirp), 'Should have followed users chirps'
    end
    john.chirps.each do |chirp|
      assert john.feed.include?(chirp), 'Should have own chirps'
    end
    jack.chirps.each do |chirp|
      assert_not john.feed.include?(chirp), 'shoudl not have other users chirps'
    end
  end
end
