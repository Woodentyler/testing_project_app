require 'rails_helper'

RSpec.describe User, type: :model do

  subject(:user) do
    User.create!(
      username: "gerald",
      password: "super_secret_password"
    )
  end

  describe "password encryption" do
    it "does not save passwords to the database" do

      User.create!(username: "mary_mack", password: "abcdef")
      user = User.find_by_username("mary_mack")
      expect(user.password).not_to be("abcdef")
    end

    it "encrypts password using BCrypt" do
      expect(BCrypt::Password).to receive(:create)
      User.new(username: "mary_mack", password: "abcdef")
    end
  end

  describe "find by credentials" do
    it "should find a user with correct username and password" do
      User.create!(username:"steve", password: "123456")
      user = User.find_by_credentials('steve','123456')
      expect(user.username).to eq('steve')
      expect(user.is_password?(123456)).to eq(true)
    end

    it "should not find a user with incorrect credentials" do
      User.create!(username:"steve", password: "123456")

      user = User.find_by_credentials('steve','abracadra')
      expect(user).to be_nil
    end

  end

  describe "reset session token" do
    it "should change the user's session token" do
      User.create!(username:"steve", password: "123456")
      user = User.find_by_credentials('steve','123456')

      session_token = user.session_token
      user.reset_token!

      expect(session_token).not_to eq(user.session_token)
    end
  end

  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }
  it { should validate_presence_of(:session_token)}
  it { should validate_presence_of(:password_digest)}


end
