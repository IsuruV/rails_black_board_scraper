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
        @classrooms = current_user.classrooms
    end
    
    private
    def classroom_params
        params.require(:id)
    end
end
