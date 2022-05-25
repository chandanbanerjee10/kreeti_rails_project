class JobsController < ApplicationController
    before_action :require_recruiter , except: [:index, :show] 
    def index
        @jobs = Job.all
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
          flash[:success] = "Jobsuccessfully created"
          redirect_to jobs_path
        else
          flash[:error] = "Something went wrong"
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
          flash[:error] = "Something went wrong"
          render 'edit', status: :unprocessable_entity
        end
    end
    
    def destroy
        @job = Job.find(params[:id])
        if @job.destroy
            flash[:success] = 'Job is successfully deleted.'
            redirect_to jobs_path, status: :see_other
        end
    end
    

    private
    def job_params
        params.require(:job).permit(:title, :job_description, :job_location, :keyskills, :sector_id, :type_id, :user_id)
    end
    
end