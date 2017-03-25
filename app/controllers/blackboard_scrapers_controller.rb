class BlackboardScrapersController < ApplicationController
    def new
        scraper = BlackboardScraper.new(login_params)
        scraper.scrape_classes
        scraper.scrape_roster
        render json: {student_name: scraper.student_name, classes: scraper.classes}
    end
    
  private
    def login_params
        params.permit(:username, :password)
    end
end

