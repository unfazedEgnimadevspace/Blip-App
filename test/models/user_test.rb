require "test_helper"

class UserTest < ActiveSupport::TestCase
 setup do 
  @user = User.new(name: "Akalugo Daniel", email: "akalugidaniel@gmail.com", password: "foobar", password_confirmation: "foobar")
 end

  test "should be valid" do
    assert @user.valid?
  end

  test "checking for name presence" do
   @user.name = '  '
   assert_not @user.valid?
  end

  test 'checking for email presence ' do
    @user.email = ' '
    assert_not @user.valid? 
  end

  test "checking for name length" do
    @user.name = "a" * 51 
    assert_not @user.valid?
  end

  test "checking for email length" do 
    @user.email = 'a' * 245 + "example.com" 
    assert_not @user.valid? 
  end

  test "check that all this email addresses are valid" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
      first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do | email_address |
      @user.email = email_address
      assert @user.valid?, "#{email_address.inspect}  is valid"
    end      
  end

  test "check that all these email addresses are invalid" do
    invalid_adresses = %w[user@example,com user_at_foo.org user.name@example.
      foo@bar_baz.com foo@bar+baz.com]
    invalid_adresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} is invalid" 
    end    
  end 

  test "email should unique" do 
    duplicate_user = @user.dup 
    @user.save 
    assert_not duplicate_user.valid?
  end
  test "email should be downcased before they are saved" do
    mixed_case_email = "FoOBar@example.com"
    @user.email = mixed_case_email
    @user.save 
    assert_equal @user.reload.email, mixed_case_email.downcase
  end
  test "user password should be present and have a minimum length of 6" do 
    @user.password = " "
    assert_not @user.valid? 
    @user.password = "aaaa"
    assert_not @user.valid? 
    @user.password = "akalugo"
    @user.password_confirmation = "akalugo"
    assert @user.valid?
  end
  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?('')
    end
end
