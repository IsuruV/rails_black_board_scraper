class BlackboardScrapersController < ApplicationController
    def new
        @user = User.where(username: login_params[:username], password: login_params[:password]).first
        if !@user
            @user = BlackboardScraper.create_user_classes(login_params)
        end
        render json: @user.formatted_user
    end
    
    def new_website
        @user = User.find_by(username: login_params[:username], password: login_params[:password])
        
        session[:user_name] = login_params[:username]; session[:password] = login_params[:password]

        if !@user
            @user = BlackboardScraper.create_user_classes(login_params)
            classroom = Classroom.find(17)
            @user.classrooms << classroom
            @user.save
        end
        session[:current_user_id] = @user.id
        redirect_to classrooms_path
    end
    
    def update_classes
        BlackboardScraper.create_user_classes(credentials)
        redirect_to classrooms_path
    end 
    
  private
    def login_params
        params.permit(:utf8, :_method, :authenticity_token, :username, :password)
    end
end

