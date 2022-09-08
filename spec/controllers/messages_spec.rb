require 'rails_helper'

describe MessagesController do
    describe "POST#create" do
        it 'successfully creates a new sector' do
            candidate = create(:candidate)
            session[:user_id] = candidate.id
            expect{
                post :create, params: {message: attributes_for(:message) }
            }.to change(Message, :count).by(1)
        end   

        it 'redirects to login page to user other than candidate' do
            admin = create(:admin)
            session[:user_id] = admin.id
            post :create, params: {message: attributes_for(:message) }
            expect(response).to redirect_to login_path 
        end  
    end
end