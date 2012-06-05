class CreateHistories < ActiveRecord::Migration
 def self.up
     create_table :histories do |t|
       t.string :message # title, name, or object_id
       t.string :username
       t.integer :item
       t.string :table_name
       t.timestamps
    end
    add_index(:histories, [:item, :table_name])
  end

  def self.down
    drop_table :histories
  end
end
