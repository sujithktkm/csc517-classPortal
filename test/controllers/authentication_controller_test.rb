require 'test_helper'

class AuthenticationControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @controller = AuthenticationsController.new
  end

  test 'User login' do
    user = users :one
    post :create, session: {email: user.email, password: 'password', name: user.name, type: user.type }
    assert_equal user.id, session[:user_id]
    assert_redirected_to root_path
  end

  test 'Validate email field' do
    post :create, session: {email: nil, password: 'password'}
    assert_nil session[:user_id]
    assert_redirected_to login_path
  end

  test 'Validate password field' do
    post :create, session: {email: 'email@email.com', password: nil}
    assert_nil session[:user_id]
    assert_redirected_to login_path
  end

  test 'Can user logout' do
    user = users :one
    session[:user_id] = user.id
    delete :destroy
    assert_nil session[:user_id]
    assert_redirected_to login_path
  end

end
