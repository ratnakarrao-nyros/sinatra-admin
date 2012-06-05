class Student < ActiveRecord::Migration
  def self.up
	create_table :students do |t|
      	t.timestamps
      	t.string :stname, :null => false
	end  
  end

  def self.down
	drop_table :employees
  end
end
