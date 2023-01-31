require "test_helper"

class UserProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:micheal)
  end

  test "profile display" do
      get user_path(@user)
      assert_template 'users/show'
      assert_select 'title', full_title(@user.name)
      assert_select 'span', text: @user.name
      assert_match @user.microposts.count.to_s, response.body
      assert_select 'div.pagination'
  end
  
end
