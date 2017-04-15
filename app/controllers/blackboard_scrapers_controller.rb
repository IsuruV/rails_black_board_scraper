class BlackboardScrapersController < ApplicationController
    def new
        @user = User.where(login_params).first
        if !@user
            @user = BlackboardScraper.create_user_classes(login_params)
        end
        render json: @user.formatted_user
    end
    
    def new_website
        @user = User.find_by(login_params)
        if !@user
            @user = BlackboardScraper.create_user_classes(login_params)
        end
        session[:current_user_id] = @user.id
        redirect_to classrooms_path
    end
  private
    def login_params
        params.permit(:username, :password)
    end
end

