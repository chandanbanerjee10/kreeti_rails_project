require 'rails_helper'

RSpec.describe Sector, :type => :model do
    before do
        @sector = Sector.new(name: "Banking")
        @user = User.new(username: "Example User", email: "user@example.com", password: "password")
    end
    
    it "is not valid without an user" do
        expect(@sector).to_not be_valid  
    end

    it "is valid with an user" do
        @sector.user = @user
        expect(@sector).to be_valid  
    end

    it "is not valid with a blank name" do
        @sector.name = ""
        expect(@sector).to_not be_valid  
    end

    it "is not valid with inappropriate name" do
        @sector.name = "99IT"
        expect(@sector).to_not be_valid  
    end

    it "is valid with appropriate name" do
        @sector.name = "Manufacturing"
        @sector.user = @user
        expect(@sector).to be_valid  
    end

    it "should have unique name" do
        @sector.user = @user
        @sector.save
        @sector1 = Sector.new(name: "Banking", user: @user)
        expect(@sector1).to_not be_valid  
    end

    # Association Checks
    context 'associations' do
        it { should have_many(:jobs).class_name('Job') }
    end

    context 'associations' do
        it { should belong_to(:user).class_name('User') }
    end
end