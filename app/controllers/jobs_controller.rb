class JobsController < ApplicationController
    before_action :require_user , only: [:show] 
    before_action :require_recruiter , except: [:index, :show] 
    before_action :require_same_recruiter, only: [:edit, :update, :destroy] 

    def index
        if params[:query].present?
            @jobs = Job.where("title LIKE ? OR job_location LIKE ? OR keyskills LIKE?", "%#{params[:query]}%","%#{params[:query]}%", "%#{params[:query]}%").page params[:page]
        elsif params[:sector].present?
            @jobs = Job.all.sector(params[:sector]).page params[:page]
        elsif params[:type].present?
            @jobs = Job.all.type(params[:type]).page params[:page]    
        else
            @jobs = Job.page params[:page]
        end
    end
    
    def show
        @job = Job.find(params[:id])
    end

    def new
        @job = Job.new
    end

    def create
        @job = Job.new(job_params)
        @job.user = current_user
        if @job.save
          flash[:success] = "Job successfully created and pending for admin approval"
          redirect_to jobs_path
        else
          flash[:notice] = "Job cannot be created due to some errors"
          render 'new', status: :unprocessable_entity
        end
    end

    def edit
        @job = Job.find(params[:id])
    end

    def update
        @job = Job.find(params[:id])
        if @job.update(job_params)
          flash[:success] = "Job was successfully updated"
          redirect_to jobs_path
        else
          flash[:notice] = "Job cannot be updated due to some errors"
          render 'edit', status: :unprocessable_entity
        end
    end
    
    def destroy
        @job = Job.find(params[:id])
        if @job.destroy
            flash[:success] = 'Job is successfully deleted.'
            redirect_to jobs_path, status: :see_other
        else
            flash[:notice] = 'There was an error regarding deletion of this job'
            redirect_to jobs_path, status: :see_other
        end
    end
    
    private
    def job_params
        params.require(:job).permit(:title, :job_description, :job_location, :keyskills, :sector_id, :type_id, :user_id, :organisation_name)
    end

    def require_same_recruiter
        @job = Job.find(params[:id])
        if current_user != @job.user
            flash[:danger] = "You can only edit or delete your own jobs"
            redirect_to jobs_path
        end
    end
    
end