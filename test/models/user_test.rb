require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @user = User.new(name: "sujang", email: "sujang.kang@gmail.com", password: "abcd", password_confirmation: "abcd")
  end
  
  test "should be valid" do
    assert @user.valid?
  end
  
  test "name should be presence" do
    @user.name = "   "
    assert_not @user.valid?
  end

  test "email should be presence" do
    @user.email = "   "
    assert_not @user.valid?
  end
  
  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end
  
  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end
  
  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    dup_user = @user.dup
    dup_user.email = @user.email.dup.upcase
    @user.save
    assert_not dup_user.valid?
  end

  test "email saved downcase" do
    IGNORE_EMAIL = "sAmpLE@eXamPlE.Com"
    @user.email = IGNORE_EMAIL
    @user.save
    assert IGNORE_EMAIL.downcase, @user.reload.email
  end
  
  test "password should not too short" do
    @user.password = @user.password_confirmation = "a" * 3
    assert_not @user.valid?
  end
  
  test "password should not be blank" do
    @user.password = @user.password_confirmation = " " * 4
    assert_not @user.valid?
  end
  
end
