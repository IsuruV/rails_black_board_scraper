class BlackboardScrapersController < ApplicationController
    def new
        @user = User.where(login_params).first
        if !@user
         @user = BlackboardScraper.create_user_classes(login_params)
         render json: @user
        else
         render json: @user.formatted_user
        end
    end
    
  private
    def login_params
        params.permit(:username, :password)
    end
end

