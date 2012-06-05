class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.timestamps
      t.string :commentable_id
      t.string :commentable_type
      t.text :content 
    end
  end

  def self.down
    drop_table :comments 
  end
end
