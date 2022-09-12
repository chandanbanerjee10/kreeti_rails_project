require 'rails_helper'

RSpec.describe Post, :type => :model do
    before do
        @user = User.create(username: "Example User", email: "user@example.com", password: "password", role: "candidate")
        @job = create(:job)
        @post = Post.new( name: "Test",
                        post_description: "I want to apply for this job",
                        username: "test_1999",
                        phone_number: 9876543210,
                        city: "Baidyabati",
                        user: @user,
                        job: @job
                )
        @post.file.attach(io: File.open('app/assets/files/rspec.pdf'), filename: 'rspec.pdf', content_type: 'application/pdf')
    end

    # Name
    it "is not valid for nil name" do
        @post.name = ""
        expect(@post).to_not be_valid
    end

    it "is not valid for an inappropriate name" do
        @post.name = "$Chandan"
        expect(@post).to_not be_valid
    end

    it "is not valid for length less than 3" do
        @post.name = "a"
        expect(@post).to_not be_valid
    end

    it "is valid for appropriate name" do
        @post.name = "chandan banerjee"
        expect(@post).to be_valid
    end

    # Post Description
    it "is not valid for blank description" do
        @post.post_description = ""
        expect(@post).to_not be_valid
    end

    it "is valid for appropriate description" do
        @post.post_description = "I want to work here"
        expect(@post).to be_valid
    end

    # Username
    it "is not valid for a blank username" do
        @post.username = ""
        expect(@post).to_not be_valid
    end

    it "is not valid for a inappropriate username" do
        @post.username = "23Chandan$199"
        expect(@post).to_not be_valid
    end

    it "is valid for an appropriate username" do
        @post.username = "chandan_1999"
        expect(@post).to be_valid
    end

    # Phone Number
    it "is not valid for a blank phone number" do
        @post.phone_number = nil
        expect(@post).to_not be_valid
    end

    it "is not valid for a inappropriate phone number" do
        @post.phone_number = 1990
        expect(@post).to_not be_valid
    end

    it "is valid for an appropriate phone number" do
        @post.phone_number = 9674694167
        expect(@post).to be_valid
    end

    # City
    it "is not valid for a blank city" do
        @post.city = ""
        expect(@post).to_not be_valid
    end
    it "is not valid for a inappropriate city" do
        @post.city = "3%Kol *kata"
        expect(@post).to_not be_valid
    end

    it "is valid for an appropriate city" do
        @post.city = "Brooklyn Street"
        expect(@post).to be_valid
    end

    # File
    it "is not valid for a blank file" do
        @post.file = nil
        expect(@post).to_not be_valid
    end

    it "is not valid for an image" do
        @post.file.attach(io: File.open('app/assets/images/test.jpg'), filename: 'test.jpg')
        expect(@post).to_not be_valid
    end

    it "is valid for a pdf file" do
        expect(@post).to be_valid
    end

    # Association Checks
    context 'associations' do
        it { should belong_to(:user).class_name('User') }
    end

    context 'associations' do
        it { should belong_to(:job).class_name('Job') }
    end
end