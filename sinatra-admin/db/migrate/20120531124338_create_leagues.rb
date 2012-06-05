class CreateLeagues < ActiveRecord::Migration
  def self.up
    create_table :leagues do |t|
      t.timestamps
      t.string :name, :null => false
    end
  end

  def self.down
    drop_table :leagues 
  end
end
