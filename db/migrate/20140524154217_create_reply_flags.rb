class CreateReplyFlags < ActiveRecord::Migration
  def change
    create_table :reply_flags do |t|
      t.integer :reply_id
      t.integer :user_id

      t.timestamps
    end
  end
end
