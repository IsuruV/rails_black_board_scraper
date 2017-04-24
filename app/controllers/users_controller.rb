class UsersController < ApplicationController
  
 def log_off
  current_user = nil
  redirect_to root_path
 end  
 
 def login
     @user = User.new
    render 'login'
 end
 
end
