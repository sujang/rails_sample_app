require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "invalid signup information" do
    get signup_path
    assert_no_difference "User.count" do
      post signup_path, params: { user: { name: "test", email: "abc@example.com", password: "aaa", password_confirmation: "bbb" } }
      assert_template "users/new"
      assert_select 'form[action="/signup"]'
    end
  end
  
  test "success signup" do
    get signup_path
    user = User.new(name: "test_1", email: "abc@aaa.bbb", password: "abcd", password_confirmation: "abcd")
    post signup_path, params: { user: { name: "test_1", email: "abc@aaa.bbb", password: "abcd", password_confirmation: "abcd"} }
    follow_redirect!
    assert_template "users/show"
  end
  
  test "valid signup complete" do
    get signup_path
    assert_difference "User.count", 1 do
      post users_path, params: { user: { name: "test", email: "example@abc.com", password: "pass", password_confirmation: "pass" } }
    end
    follow_redirect!
    assert_template "users/show"
    assert_not flash.empty?
  end
end
