class Classroom < ActiveRecord::Base
    has_many :user_classrooms
    has_many :users, :through => :user_classrooms
    has_many :rosters
    has_many :messages
    # has_many :users, through: :messages
end
