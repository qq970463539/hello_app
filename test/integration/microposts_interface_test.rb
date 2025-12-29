require "test_helper"

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:qqkun)
  end

  test "micropost interface" do
    log_in_as(@user, remember_me: "1")
    get root_path
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", users_path
    assert_select "input[type=submit]"

    # invalid submission
    assert_no_difference "Micropost.count" do
      post microposts_path, params: { micropost: { content: "" } }
    end

    # valid submission
    content = "This micropost really ties the room together"
    assert_difference "Micropost.count", 1 do
      post microposts_path, params: { micropost: { content: content } }
    end
    follow_redirect!
    assert_match content, response.body

    # delete a post
    first_micropost = @user.microposts.first
    assert_difference "Micropost.count", -1 do
      delete micropost_path(first_micropost)
    end
  end
end