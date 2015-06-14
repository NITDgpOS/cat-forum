class CreateBlockeds < ActiveRecord::Migration
  def self.up
    create_table :blockeds do |t|
      t.boolean :status, default: false

      t.timestamps
    end
  end

  def self.down
    drop_table :blockeds
  end
end
