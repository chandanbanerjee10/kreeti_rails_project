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
        if @job.save
            @job.approved_by = current_user.id
            @job.save!
            flash[:notice] = "Job was approved successfully."
            redirect_to admin_job_requests_path, status: :see_other
        else
            flash[:notice] = "There was an error regarding saving this job"
            redirect_to admin_job_requests_path
        end
    end

    def job_reject
        @job = Job.find(params[:id])
        if @job.destroy
            flash[:success] = 'Job is successfully deleted.'
            redirect_to admin_job_requests_path, status: :see_other
        else
            flash[:danger] = "There was an error regarding deleting this job. Please try after somethime"
            redirect_to admin_job_requests_path, status: :see_other
        end
    end
end