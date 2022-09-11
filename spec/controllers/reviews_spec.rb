require 'rails_helper'

describe ReviewsController do
    describe "POST#create" do
        it "creates a review in the job show page from any user" do
            job = create(:job)
            candidate = create(:candidate)
            session[:user_id] = candidate.id
            expect{
                post :create, params: {review: attributes_for(:review, user_id: candidate), job_id: job.id}
            }.to change(Review, :count).by(1)
        end
    end
    
end