class AddSlugToNewThreads < ActiveRecord::Migration
  def up
    add_column :new_threads, :slug, :string
    add_index :new_threads, :slug
  end

  def down
    remove_index :new_threads, :slug
    remove_column :new_threads, :slug
  end
end
