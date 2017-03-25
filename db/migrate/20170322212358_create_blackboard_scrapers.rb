class CreateBlackboardScrapers < ActiveRecord::Migration
  def change
    create_table :blackboard_scrapers do |t|

      t.timestamps null: false
    end
  end
end
