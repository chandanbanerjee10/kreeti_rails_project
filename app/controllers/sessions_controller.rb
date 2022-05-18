class SessionsController < ApplicationController

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
end
