require 'test_helper'

class AuthenticationControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'User login' do
    login_user = users :one
    post :create, session: {email: 'email@email.com', password: 'password', name: 'name', type: 'Student' }
    assert_equal login_user.id, session[:user_id]
    assert_redirected_to root_path
  end

  test 'Validate fields' do
    post :create, session: {email: nil, password: nil}
    assert_nil session[:user_id]
    assert_redirected_to login_path
  end

  test 'Can user logout' do
    login_user = users :one
    session[:user_id] = login_user.id
    delete :destroy
    assert_nil session[:user_id]
    assert_redirected_to login_path
  end

end
