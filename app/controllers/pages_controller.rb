class PagesController < ApplicationController
    def home
      @jobs = Job.order("id").page(params[:page]).per(6)
    end        
end