class CreateNew < ActiveRecord::Migration
  def self.up

	create_table :newteams do |t|
      	t.timestamps
      	t.string :teamname, :null => false
    end

  end

  def self.down
	drop_table:newteams
  end
end


