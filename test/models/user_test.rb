require "test_helper"

class UserTest < ActiveSupport::TestCase

    def setup
        @user = User.new(username: "Chandan", email: "chandan.banerjee@kreeti.com", password: "chandan", role: "admin")
    end

    test "username should be valid" do
        @user.username = ""
        assert_not @user.valid?
    end

    test "email should be valid" do
        @user.email = "abc..."
        assert_not @user.valid?
    end

    test "password should be valid" do
        @user.password = "" 
        #This is giving a strange error. In console password attribute does not accept an empty string. But here, it is expecting a true value. ??
        assert_not @user.valid?
    end

    test "username should be unique" do
        @user.save 
        @user1 = User.new(username: "Chandan", email: "chandan.banerjee1@kreeti.com", password: "chandan1")
        assert_not @user1.valid?
    end

    test "email should be unique" do
        @user.save 
        @user1 = User.new(username: "Chandan1", email: "chandan.banerjee@kreeti.com", password: "chandan1")
        assert_not @user1.valid?
    end

    test "password should not be too short" do
        @user.password = "a"*5
        assert_not @user.valid?
    end

    # Association checks
    test '#posts' do
        assert_equal 0, @user.posts.size
    end
    test '#sectors' do
        assert_equal 0, @user.sectors.size
    end
    test '#types' do
        assert_equal 0, @user.types.size
    end
    test '#jobs' do
        assert_equal 0, @user.jobs.size
    end
    test '#reviews' do
        assert_equal 0, @user.reviews.size
    end
    test '#messages' do
        assert_equal 0, @user.messages.size
    end
end