class SessionsController < ApplicationController
    before_action :logged_in_redirect, only: [:new, :create]
    def new
    end

    def create
        @user = User.find_by(email: params[:session][:email].downcase)
        if @user && @user.authenticate(params[:session][:password])
            session[:user_id] = @user.id
            flash[:notice] = "logged in successfully"
            redirect_to @user
        else
            flash.now[:danger] = "There is something wrong with your login information"
            render 'new', status: :unprocessable_entity
        end
    end

    def show

    end

    def destroy
        session[:user_id] = nil
        flash[:notice] = "Logged out Successfully"
        redirect_to users_path, status: :see_other
    end

    private

    def logged_in_redirect
        if logged_in?
            flash[:error] = "You are already logged in"
            redirect_to root_path
        end
    end 
end
