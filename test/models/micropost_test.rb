require "test_helper"

class MicropostTest < ActiveSupport::TestCase
  setup do
    @user = users(:micheal)
    @micropost = @user.microposts.build(content: "Daniel is a brilliant coder")
  end

  test "a valid micropost with a user id present" do 
    assert @micropost.valid?
  end

  test "a micropost without a user should not be valid" do
    @micropost.user_id = ""
    assert_not @micropost.valid?
  end

  test "assert micropost without content is not valid" do
    @micropost.content = " "
    assert_not @micropost.valid?
  end
  test "micropost with content length greater than 140 should not be valid" do
    @micropost.content =  "a" * 141
    assert_not @micropost.valid?
  end
  test "micropost order should be the most recent" do
    assert_equal microposts(:most_recent), Micropost.first
  end
end
