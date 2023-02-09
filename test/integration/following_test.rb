require "test_helper"

class FollowingTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:micheal)
    log_in_as(@user)
  end
  
 
end
