require 'rails_helper'

RSpec.describe Type, :type => :model do
    before do
        @type = Type.new(name: "Clerk")
        @user = User.new(username: "Example User", email: "user@example.com", password: "password")
    end

    it "is not valid without an user" do
        expect(@type).to_not be_valid  
    end

    it "is valid with an user" do
        @type.user = @user
        expect(@type).to be_valid  
    end

    it "is not valid with a blank username" do
        @type.name = ""
        expect(@type).to_not be_valid  
    end

    it "is not valid with inappropriate username" do
        @type.name = "99Clerk"
        expect(@type).to_not be_valid  
    end

    it "is valid with appropriate username" do
        @type.name = "SDE-2"
        @type.user = @user
        expect(@type).to be_valid  
    end

    it "should have unique name" do
        @type.user = @user
        @type.save
        @type1 = Type.new(name: "Clerk", user: @user)
        expect(@type1).to_not be_valid  
    end

    # Association Checks
    
    context 'associations' do
        it { should have_many(:jobs).class_name('Job') }
    end

    context 'associations' do
        it { should belong_to(:user).class_name('User') }
    end
end