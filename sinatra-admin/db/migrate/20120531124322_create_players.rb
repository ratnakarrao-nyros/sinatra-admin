class CreatePlayers < ActiveRecord::Migration
 def self.up
    create_table :players do |t|
      t.timestamps
      t.string :name, :limit => 100, :null => false
      t.integer :team_id
      t.string :position, :limit => 50
      t.integer :number, :null => false
      t.boolean :retired, :default => false
      t.boolean :injured, :default => false
      t.date :born_on
      t.text :notes
     t.datetime :deleted_at
    end
  end

  def self.down
    drop_table :players
    remove_column :comments, :post_id
  end
end

