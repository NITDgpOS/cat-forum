class AddPointsToUser < ActiveRecord::Migration
  def change
  	change_table :users do |t|
      t.integer :points, default: 100
      t.string :badge, default: "Gungan"
    end
  end
end
