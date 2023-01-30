require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
   @user = users(:micheal)
   @other_user = users(:archer)
  end
  test "should get new" do
    get users_new_url
    assert_response :success
  end
  test "should redirect edit when not logged in" do
    get edit_user_path(@user)
    assert_redirected_to login_url 
    assert_not flash.empty?
  end
  test "should redirect update when not logged in" do
      patch user_path(@user), params: { user: { name: @user.name,
      email: @user.email } }
      assert_not flash.empty?
      assert_redirected_to login_url
  end

  test "should not allow another user access to another user edit page"do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert_redirected_to root_url 
    assert flash.empty? 
  end
  test "should not allow another user to send patch request to another user update action" do
    log_in_as(@other_user)
    patch user_path(@user), params: { user: { name: @user.name, email: @user.email}}
    assert flash.empty?
    assert_redirected_to root_url
  end
  test "redirect user to login url if the user trys to access the index action without being logged in" do
    get users_path 
    assert_response :redirect
    assert_redirected_to login_url
  end
  test "should not allow the admin attribute to be editable through the web" do
    log_in_as(@other_user)
    assert_not @other_user.admin? 
    patch user_path(@other_user), params: { user: { name: @other_user.name, email: @other_user.email, password: "password", password_confirmation: "password", admin: true}}
    assert_not @other_user.reload.admin?
  end
  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete user_path(@other_user)
    end
    assert_response :redirect
    assert_redirected_to login_url
  end
  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
    delete user_path(@user)
    end
    assert_redirected_to root_url
  end
end
