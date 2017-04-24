class ClassroomsController < ApplicationController
    def show
        @classroom = Classroom.find(classroom_params)
        @message = Message.new
        # render json: class_room.messages
      respond_to do |format|
          format.html
          format.json { render :json => @classroom.messages.to_json }
        end
    end
    
    def index
        # @classrooms = Classroom.all
        # render json: @classrooms
        @user = current_user
        respond_to do |format|
          format.html { @classrooms = current_user.classrooms }
          format.json { render :json => Classroom.all.to_json }
        end
    end
    
    private
    def classroom_params
        params.require(:id)
    end
end
