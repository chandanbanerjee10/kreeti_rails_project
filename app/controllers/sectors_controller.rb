class  SectorsController < ApplicationController
    before_action :require_user 
    before_action :require_admin_recruiter, only: [:new, :create]
    before_action :require_admin, except: [:new, :create]

    def new
        @sector = Sector.new
    end

    def create
        @sector= Sector.new(sector_params)
        @sector.user = current_user
        if current_user.is_admin?
            if @sector.save
                flash[:success] = "Sector successfully created"
                redirect_to sectors_path
            else
                render 'new' , status: :unprocessable_entity
            end
        else
            if @sector.save
                flash[:success] = "Sector successfully created"
                redirect_to new_sector_path
            else
                render 'new' , status: :unprocessable_entity
            end
        end
    end

    def index
        @sectors = Sector.page params[:page]
    end

    def destroy
        @sector = Sector.find(params[:id])
        if @sector.destroy
            flash[:danger] = "Sector successfully deleted"
            redirect_to sectors_path, status: :see_other
        else
            flash[:notice] = "There was a problem regarding deletion of this sector"
            redirect_to sectors_path, status: :see_other
        end
    end

    def edit
        @sector = Sector.find(params[:id])
    end

    def update
        @sector = Sector.find(params[:id])
        @sector.user = current_user
        if @sector.update(sector_params)
            flash[:success] = "Sector successfully updated"
            redirect_to sectors_path
        else
            render 'edit' , status: :unprocessable_entity
        end
    end
    private
    def sector_params
        params.require(:sector).permit(:name)
    end
end