class CreateReplies < ActiveRecord::Migration
  def self.up
    create_table :replies do |t|
      t.integer "user_id"
      t.references :new_thread
      t.text "content", :limit => nil
      t.timestamps
    end
    add_index("replies", "user_id")
  end

  def self.down
  	drop_table :replies
  end
end
