require 'rails_helper'

RSpec.describe Job, :type => :model do
    before do
        @user = User.create(username: "Example User", email: "user@example.com", password: "password", role: "admin")
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
    end

    # Title
    it "is not valid for a blank title" do
        @job.title = ""
        expect(@job).to_not be_valid
    end

    it "is not valid for an inappropriate title" do
        @job.title = "@Dog Trainer"
        expect(@job).to_not be_valid
    end

    it "is valid for an appropriate title" do
        @job.title = "SDE-2"
        expect(@job).to be_valid
    end

    #  Description
    it "is not valid for a blank description" do
        @job.job_description = ""
        expect(@job).to_not be_valid
    end

    # Location
    it "is not valid for a blank location" do
        @job.job_location = ""
        expect(@job).to_not be_valid
    end

    it "is not valid for an inappropriate location" do
        @job.job_location = "12334 Kolkata"
        expect(@job).to_not be_valid
    end

    it "is valid for an appropriate location" do
        @job.job_location = "North 24 Parganas"
        expect(@job).to be_valid
    end

    # Skills
    it "is not valid for a blank skills" do
        @job.keyskills= ""
        expect(@job).to_not be_valid
    end

    it "is not valid for inappropriate skills" do
        @job.keyskills= "*rails%"
        expect(@job).to_not be_valid
    end

    it "is valid for appropriate skills" do
        @job.keyskills= "rails-7"
        expect(@job).to be_valid
    end

    # Organisation
    it "is not valid for a blank organisation" do
        @job.organisation_name= ""
        expect(@job).to_not be_valid
    end

    it "is not valid for inappropriate organisation" do
        @job.organisation_name= "!Howwzzat"
        expect(@job).to_not be_valid
    end

    it "is valid for appropriate organisation" do
        @job.organisation_name= "Space-X"
        expect(@job).to be_valid
    end

    # User, sector and type
    it "is not valid without an user" do
        @job.user = nil
        expect(@job).to_not be_valid
    end

    it "is not valid without a sector" do
        @job.sector = nil
        expect(@job).to_not be_valid
    end

    it "is not valid without a type" do
        @job.type = nil
        expect(@job).to_not be_valid
    end

    # Association Checks
    context 'associations' do
        it { should belong_to(:user).class_name('User') }
    end

    context 'associations' do
        it { should belong_to(:sector).class_name('Sector') }
    end

    context 'associations' do
        it { should belong_to(:type).class_name('Type') }
    end
    
    context 'associations' do
        it { should have_many(:posts).class_name('Post') }
    end

    context 'associations' do
        it { should have_many(:reviews).class_name('Review') }
    end
end