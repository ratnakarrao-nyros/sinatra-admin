class Employee < ActiveRecord::Migration
  def self.up
	
	create_table :employees do |t|
      	t.timestamps
      	t.string :empname, :null => false
	end  

end

  def self.down
	drop_table :employees
  end
end
