class CreateNewThreadFlags < ActiveRecord::Migration
  def change
    create_table :new_thread_flags do |t|
      t.integer :new_thread_id
      t.integer :user_id

      t.timestamps
    end
  end
end
