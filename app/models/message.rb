class Message < ApplicationRecord
    belongs_to :user
    belongs_to :classroom
    
    def message_format
        user = self.user
        { "user": {id: user.id, name: user.name, username: user.username }, "message": self }
    end
end
