class ClassroomsController < ApplicationController
    def show
        class_room = Classroom.find(classroom_params)
        render json: class_room.messages
    end
    
    private
    def classroom_params
        params.require(:id)
    end
end
