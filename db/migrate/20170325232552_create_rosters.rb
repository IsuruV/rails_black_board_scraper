class CreateRosters < ActiveRecord::Migration[5.1]
  def change
    create_table :rosters do |t|
      t.integer :classroom_id
      t.string :name
      t.timestamps null: false
    end
  end
end
