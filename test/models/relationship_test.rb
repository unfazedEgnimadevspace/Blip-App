require "test_helper"

class RelationshipTest < ActiveSupport::TestCase
  def setup
    @relationship = Relationship.new(follower_id: users(:micheal).id,
    followed_id: users(:archer).id)
  end
  test "should be valid" do
    assert @relationship.valid?
  end
  test "should require a follower_id" do
    @relationship.follower_id = nil
  end  
end
