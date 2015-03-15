require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'invalid registration information' do
    get register_path
    assert_no_difference 'User.count' do
      post users_path, user: { name: '',
                               email: 'invalid',
                               password: 'short',
                               password_confirmation: 'nomatch' }
    end
    assert_template 'users/new'
  end

  test 'valid registration information' do
    get register_path
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: { name: 'Test Testington',
                                            email: 'test@example.org',
                                            password: 'supersecret',
                                            password_confirmation: 'supersecret' }
    end
    assert_template 'users/show'
  end
end
