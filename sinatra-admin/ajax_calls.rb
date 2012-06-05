require 'date'
require 'time'
require 'csv'
require 'json'
require 'will_paginate'
require 'will_paginate/active_record'


get '/addnew' do
	@tab_name=params[:table]
	model=model_for_table @tab_name
	@column_arr=model.column_names		
	erb :addnew, :layout => false
end

get '/pts' do	
	content_type :json
	@doc=Array.new
	if params[:id] == "player" 		
		@player=Player.all	
		puts @player.inspect
		@player.each_with_index do |item,index| 
		@doc[index]={"optionValue" =>index, "optionDisplay"=>item.name}
		end
		@doc.to_json	
	elsif params[:id] == "team" 
		@team=Team.all
		@team.each_with_index do |item,index|
		@doc[index]={"optionValue" =>index, "optionDisplay"=>item.name}
		end
		@doc.to_json
	 end
end


get '/gethistories' do
	@history=History.select("id,message,item,username,table_name,created_at,updated_at").where("table_name='"+params[:name]+"'")	
	erb :histories ,layout =>false	
end



