require 'rails_helper'

RSpec.describe Sector, :type => :model do
    before do
        @user = User.new(username: "Example User", email: "user@example.com", password: "password")
        @sector = Sector.new(name: "Banking", user: @user)
        @type = Type.new(name: "Clerk", user: @user)
        @job = Job.new(
            title: 'Web Developer',
            job_description: 'This requires sound knowledge of programming.',
            job_location: 'Kolkata',
            keyskills: 'Ruby and Rails',
            organisation_name: 'Kreeti Technologies',
            sector: @sector,
            type: @type,
            user: @user
        )
        @review = Review.new(content: "This is a good job", user: @user, job: @job)
    end
    
    it "is not valid for a blank review" do
        @review.content = ""
        expect(@review).to_not be_valid
    end

    it "is not valid without an user" do 
        @review.user = nil
        expect(@review).to_not be_valid
    end

    it "is not valid without a job" do 
        @review.job = nil
        expect(@review).to_not be_valid
    end

    it "is valid for an appropriate review" do
        @review.save 
        expect(@review).to be_valid
    end

    # Associations check
    context 'associations' do
        it { should belong_to(:user).class_name('User') }
    end

    context 'associations' do
        it { should belong_to(:job).class_name('Job') }
    end
end