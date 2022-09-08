require 'rails_helper'

RSpec.describe Message, :type => :model do
    before do
        @message = Message.new(body: "Hello, Good morning everyone!")
        @user = create(:candidate)
    end
    
    it "is not valid without an user" do
        expect(@message).to_not be_valid  
    end

    it "is valid with an user" do
        @message.user = @user
        expect(@message).to be_valid  
    end

    it "is not valid with a blank body" do
        @message.body = ""
        expect(@message).to_not be_valid  
    end

    # Association Checks
    
    context 'associations' do
        it { should belong_to(:user).class_name('User') }
    end
end