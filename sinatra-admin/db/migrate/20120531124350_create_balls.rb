class CreateBalls < ActiveRecord::Migration
 def self.up
    create_table :balls do |t|
      t.timestamps
      t.string :color, :null => false
    end
  end

  def self.down
    drop_table :balls
  end
end
