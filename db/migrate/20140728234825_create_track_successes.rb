class CreateTrackSuccesses < ActiveRecord::Migration
  def change
    create_table :track_successes do |t|
      t.integer :user_id
      t.integer :puzzle_id
      t.boolean :success

      t.timestamps
    end
  end
end
