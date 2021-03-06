require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
  @user=User.new(name:"jell" ,email:"jello@wello.com",password:"deadtome",password_confirmation:"deadtome")
	end
	
	test "should be valid" do
	assert @user.valid?
	end
	
	test "name should be present" do
	@user.name="  "
	assert_not @user.valid?
	end
	
	test "email should be present" do
	@user.email="  "
	assert_not @user.valid?
	end
	
	test "name should not exceed limit" do
	@user.name="A"*53
	assert_not @user.valid?
	end
	
	test "email should not exceed limit" do
	@user.name="A"*256
	assert_not @user.valid?
	end
	
	test "email validation should accept valid addresses" do
	valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
		first.last@foo.jp alice+bob@baz.cn]
	valid_addresses.each do |valid_address|
	@user.email = valid_address
	assert @user.valid?, "valid_address #{valid_addresses.inspect} should be valid"
	end
	end
	
	test "email validation should reject invalid addresses" do
	invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
		foo@bar_baz.com foo@bar+baz.com]
	invalid_addresses.each do |invalid_address|
	@user.email = invalid_address
	assert_not @user.valid? "invalid_address #{invalid_addresses.inspect} should be invalid"
	end
	end
	
	test "email should be unique without case sensitivity" do
	dup_user=@user.dup;
	dup_user.email=@user.email.upcase
	@user.save
	assert_not dup_user.valid?
	
	
	end
	
	test "password should be minimum 6 characters long" do
	@user.password=@user.password_confirmation="A"*5
	assert_not @user.valid?
	
	end

end

