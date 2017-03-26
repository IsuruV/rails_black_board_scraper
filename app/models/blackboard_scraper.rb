class BlackboardScraper < ActiveRecord::Base
    require 'capybara/poltergeist'
    attr_accessor :agent, :classes, :roster, :username, :password, :student_name
    
    def initialize(login)
      ## set login for scraper instance
      self.username = login[:username]
      self.password = login[:password]
      self.create_scraper_agent
    end 
    
    def create_scraper_agent
      ## create new scraper instance
      Capybara.register_driver :poltergeist do |app|
        Capybara::Poltergeist::Driver.new(app, :phantomjs => Phantomjs.path)
      end
      Capybara.default_driver = :poltergeist
      self.agent = Capybara.current_session
    end
    
    def scrape_classes
      ## scrape the list of classes and student name
      self.classes = []
      self.agent.visit "https://bbhosted.cuny.edu/webapps/login/?userid=#{self.username}&password=#{self.password}" 
      self.student_name = self.agent.all("#global-nav-link").first.text
      self.agent.all(:css,"#_4_1termCourses_noterm ul.portletList-img.courseListing.coursefakeclass li a", :between => 1..10).map do |item|
        if item['target'] == "_top"
           self.classes.push({class_id: item['href'].match(/\id=(.*)\&url/)[1], className: item.text,roster: []})
        end
      end
    end
    
    def scrape_roster
      ## scrape each classes roster
        self.classes.each do |course|
          course_id = course[:class_id]
            self.agent.visit "https://bbhosted.cuny.edu/webapps/blackboard/execute/displayEmail?navItem=email_select_students&course_id=#{course_id}"
            student_roster = self.agent.all(:css, "#USERS_AVAIL option", :between => 1..60)
             if student_roster.length > 0
               course[:roster] = student_roster.map{|student| student.text}
             end 
        end
    end
    
    def create_user
      User.create(name: self.student_name, username: self.username, password: self.password)
    end
    
    def create_classes
      user = self.create_user
      self.classes.each do |classroom|
        room = Classroom.find_or_create_by(class_name: classroom[:className], class_id: classroom[:class_id])
        room.users << user
        room.save
        self.create_roster(room, classroom)
      end
      user.formatted_user
    end
    
    def create_roster(room, classroom)
      classroom[:roster].each do |student|
        Roster.find_or_create_by(name: student, classroom_id: room.id)
      end
    end
    
    def self.create_user_classes(login_params)
         scraper = self.new(login_params)
         scraper.scrape_classes
         scraper.scrape_roster
         scraper.create_classes
    end
    
end
# {"username":"mmalek1421", "password":"Gleo1421"}
# render json: {student_name: scraper.student_name, classes: scraper.classes}