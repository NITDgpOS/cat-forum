class CreateNewThreads < ActiveRecord::Migration
  def self.up
    create_table :new_threads do |t|
      t.integer 'user_id'
      t.string 'title'
      t.text 'description', limit: nil
      t.integer 'likes', default: 0
      t.integer 'dislikes', default: 0

      t.timestamps
    end
    add_index('new_threads', 'user_id')
  end

  def self.down
    drop_table :new_threads
  end
end
