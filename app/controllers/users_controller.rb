class UsersController < ApplicationController
    
 def login
     @user = User.new
    render 'login'
 end
 
end
