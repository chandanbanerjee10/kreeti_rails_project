class SectorsController < ApplicationController
    before_action :require_user , only: [:index] 
    before_action :require_admin, only: [:new, :create] 

    def new
        @sector = Sector.new
    end

    def create
        # debugger
        @sector= Sector.new(sector_params)
        @sector.user = current_user
        if @sector.save
          flash[:success] = "Sector successfully created"
          redirect_to admin_sectors_path
        else
          flash[:error] = "Something went wrong"
          render 'new' , status: :unprocessable_entity
        end
    end
    
    def show
        # debugger
        @sector = Sector.find(params[:id])
    end

    def index
        @sectors = Sector.all
    end
    private
    def sector_params
        params.require(:sector).permit(:name)
    end
end