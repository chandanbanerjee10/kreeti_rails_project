class ReviewsController < ApplicationController
    before_action :require_user
    
    def create
        @job = Job.find(params[:job_id])
        @review = @job.reviews.create(review_params)
        @review.user = current_user
        if !@review.save
            flash[:notice] = @review.errors.full_messages.to_sentence
        end
        redirect_to job_path(@job)
    end
    
    private
    def review_params
        params.require(:review).permit(:content)
    end
end
