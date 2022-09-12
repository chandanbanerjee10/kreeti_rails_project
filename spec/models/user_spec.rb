require 'rails_helper'

RSpec.describe User, :type => :model do

    before do
        @user = User.new(username: "Example User", email: "user@example.com", password: "password")
    end

    # Username 
    it "is not valid with a blank username" do
        @user.username = "" 
        expect(@user).to_not be_valid  
    end

    it "is not valid with inappropriate username" do
        @user.username = "92chandan" 
        expect(@user).to_not be_valid  
    end

    it "is valid with appropriate username" do
        @user.username = "chandan_1999" 
        expect(@user).to be_valid   
    end

    it "should have unique username" do
        @user.save
        @user1 = User.new(username: "Example User", email: "user1@example.com", password: "password1")
        expect(@user1).to_not be_valid  
    end

    # Email
    it "is not valid with a blank email" do
        @user.email = "" 
        expect(@user).to_not be_valid  
    end

    it "is not valid with inappropriate email" do
        @user.email = "abc#.com" 
        expect(@user).to_not be_valid  
    end

    it "is valid with appropriate email" do
        @user.email = "abc@gmail.com" 
        expect(@user).to be_valid  
    end

    it "should have unique email" do
        @user.save
        @user1 = User.new(username: "Example User1", email: "user@example.com", password: "password")
        expect(@user1).to_not be_valid  
    end

    # Password
    it "must not have nil value" do
        @user.password_digest = "" 
        expect(@user).to_not be_valid  
    end

    # Association Checks
    context 'associations' do
        it { should have_many(:posts).class_name('Post') }
    end

    context 'associations' do
        it { should have_many(:sectors).class_name('Sector') }
    end

    context 'associations' do
        it { should have_many(:types).class_name('Type') }
    end

    context 'associations' do
        it { should have_many(:jobs).class_name('Job') }
    end

    context 'associations' do
        it { should have_many(:reviews).class_name('Review') }
    end

    context 'associations' do
        it { should have_many(:messages).class_name('Message') }
    end
end



