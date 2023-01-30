require "test_helper"

class UsersIndexTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:micheal)
    @non_admin = users(:archer)
  end

  test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    get users_path 
    
    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.each do |user|
      assert_select "a[href=?]", user_path(user), text: user.name
      unless user == @admin
        assert_select "a[href=?]", user_path(user), text: "Delete"
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end
  test 'index for non-admin'do
    log_in_as(@non_admin)
    get users_path 
    assert_select "a[href=?]", user_path(@admin),  text: "Delete", count: 0
  end

end
