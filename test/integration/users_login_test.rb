require "test_hekper"

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
  end

  test "login with invalid information" do
    get login_path
    assert_template "session/new"
    post login_path,params:{ session: { email: "",password:"" } }
    assert_template"sessions/new"
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
end