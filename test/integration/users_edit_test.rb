require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:micheal)
  end
  #Unsuccesful user edit test 
  test "should not update user with bad params" do
    log_in_as(@user)
    get edit_user_path(@user) 
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: "", email: "invalid@gmail.com", password: "akalugo", password_confirmation: "daniel"}}
    assert_template 'users/edit'

  end

  #test succesful user edit test 
  test "should update a user information correctly" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = "Micheal Example"
    email = "michealexample@gmial.com"
    patch user_path(@user), params: { user: { name: name, email: email , password: "password", password_confirmation: "password"}}
    assert_redirected_to @user
    follow_redirect!
    assert_template "users/show"
    assert_not flash.empty?
    @user.reload
    assert_equal name, @user.name 
    assert_equal email, @user.email
  end

  test "test out our update with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    name = "Micheal Example"
    email = "michealexample@gmial.com"
    patch user_path(@user), params: { user: { name: name, email: email , password: "password", password_confirmation: "password"}}
    assert_redirected_to @user
    follow_redirect!
    assert_template "users/show"
    assert_not flash.empty?
    @user.reload
    assert_equal name, @user.name 
    assert_equal email, @user.email
  end
   
end
