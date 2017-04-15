class User < ActiveRecord::Base
    has_many :user_classrooms
    has_many :classrooms, :through => :user_classrooms
    validates :username, presence: true, uniqueness: true
    
    def formatted_user
        classes = []
        self.classrooms.each do |room|
            roster_list = room.rosters.map{|roster| roster.name }
            classes.push({id: room.id, class_id: room.class_id, classname: room.class_name, roster: roster_list})
        end
        {student:{id: self.id, name: self.name, username: self.username}, classes: classes }
    end
    
    def formatted_user_message
        {id: self.id, name: self.name, username: self.username }
    end
    
    # def password
    #  @password ||= Password.new(password_hash)
    # end

    # def password=(new_password)
    #   @password = Password.create(new_password)
    #   self.password_hash = @password
    # end
    
end
