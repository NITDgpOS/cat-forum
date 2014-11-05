class CreateLikeCountReplies < ActiveRecord::Migration
  def change
    create_table :like_count_replies do |t|
      t.integer :reply_id
      t.integer :user_id

      t.timestamps
    end
  end
end
