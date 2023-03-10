require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_url
    assert_response :success
    assert_select "title", full_title("Home")
  end

  test "should get help" do
    get help_url
    assert_response :success
    assert_select "title", full_title("Help")
  end
  test "should get about page" do
    get about_url 
    assert_response :success
    assert_select "title", full_title("About")
  end
  test "should  get contact page " do
    get contact_url 
    assert_response :success
    assert_select "title", full_title("Contact")
  end
end
