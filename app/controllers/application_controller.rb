class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?

    # Using memoization so that current user is returned if it is cached. Else We have to find it.
    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    # Converting above method to boolean
    def logged_in?
        !!current_user
    end

end
