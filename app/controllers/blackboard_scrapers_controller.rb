class BlackboardScrapersController < ApplicationController
    def new
        @user = User.where(login_params).first
        if !@user
            @user = BlackboardScraper.create_user_classes(login_params)
        end
        render json: @user.formatted_user
    end
    
  private
    def login_params
        params.permit(:username, :password)
    end
end

