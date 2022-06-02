class AdminController < ApplicationController
    before_action :require_user
    before_action :require_admin

    def home
        
    end

    def job_requests
        @jobs = Job.all
    end

    def job_show
        @job = Job.find(params[:id])
    end

    def job_approve
        
        @job = Job.find(params[:id])
        @job.approved_by = current_user.id
        @job.save!
        flash[:notice] = "Job was approved successfully."
        redirect_to jobs_path
    end
end