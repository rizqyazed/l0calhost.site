require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "downcases and strips email_address" do
    user = User.new(email_address: " DOWNCASED@EXAMPLE.COM ")
    assert_equal("downcased@example.com", user.email_address)
  end

  test "username must be unique" do
    existing_user = users(:one)

    duplicate_user = User.new(
      email_address: "oneone@example.com",
      username: existing_user.username,
      password: "password"
    )

    assert_not duplicate_user.valid?

    assert_includes duplicate_user.errors[:username], "has already been taken"
  end

  test "username uniqueness is case-insensitive" do
    existing_user = users(:one)

    duplicate_user = User.new(
      email_address: "oneone@example.com",
      username: existing_user.username.upcase,
      password: "password"
    )

    assert_not duplicate_user.valid?
    assert_includes duplicate_user.errors[:username], "has already been taken"
  end

  test "account has to have both email and password to be valid" do
    user = User.new(
      username: "one",
      password: "password"
    )
    assert_not user.valid?

    user = User.new(
      email_address: "oneone@example.com",
      username: nil,
      password: "password"
    )
    assert_not user.valid?
  end

  test "username has to valid to be in a url" do
    user = User.new(
      email_address: "oneone@example.com",
      username: "helo_one",
      password: "password"
    )

    assert_not user.valid?
    assert_includes user.errors[:username], "can only contain lowercase letters, numbers, and hyphens, and cannot start or end with a hyphen"

    user.username = "helo-one"

    assert user.valid?
  end
end
