class CreateClassrooms < ActiveRecord::Migration
  def change
    create_table :classrooms do |t|
      t.string :class_id
      t.string :class_name
      t.timestamps null: false
    end
  end
end
