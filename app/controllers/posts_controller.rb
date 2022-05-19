class PostsController < ApplicationController
    before_action :require_user , only: [:new, :create] 


    def new
        @post = Post.new
    end

    def create
        @post = Post.new(post_params)
        @post.user = current_user
        if @post.save
          flash[:success] = "Job Post successfully created"
          redirect_to @post
        else
          flash[:error] = "Something went wrong"
          render 'new' , status: :unprocessable_entity
        end
    end
    

    private
    def post_params
        params.require(:post).permit(:name, :post_description, :username, :phone_number, :city)
    end
end