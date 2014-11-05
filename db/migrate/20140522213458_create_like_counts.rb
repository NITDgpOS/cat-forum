class CreateLikeCounts < ActiveRecord::Migration
  def change
    create_table :like_counts do |t|
      t.integer :new_thread_id
      t.integer :user_id

      t.timestamps
    end
  end
end
