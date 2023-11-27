require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "Clean Blog"
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "About | Clean Blog"
  end

  test "should get blog" do
    get blog_path
    assert_response :success
    assert_select "title", "Blog | Clean Blog"
  end
end
