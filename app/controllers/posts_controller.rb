class PostsController < ApplicationController
    before_action :require_user , only: [:new, :create] 
    before_action :require_recruiter, only:[:index, :destroy]
    def new
        @post = Post.new
    end

    def create
        @post = Post.create(post_params)   
        @job = Job.find(params[:job_id])
        @post.job = @job
        @post.user = current_user 
        if @post.save
          flash[:success] = "Job Post successfully created"
          redirect_to @job
        else
          flash[:error] = "Something went wrong"
          render 'new' , status: :unprocessable_entity
        end
    end
    
    def show
        @post = Post.find(params[:id])
    end

    def index
        @posts = Post.all    
        @job = Job.find(params[:job_id])
    end

    def destroy
        @post = Post.find(params[:id])
        if @post.destroy
            flash[:danger] = "Job post successfully deleted"
            redirect_to job_path(@post.job), status: :see_other
        end
    end
    private
    def post_params
        params.require(:post).permit(:name, :post_description, :username, :phone_number, :city, :file,:job_id)
    end
end