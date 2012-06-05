helpers do 
def model_for_table(table_name)
 	table_name.classify.constantize	
end
end

get '/show' do
	@tab_name=params[:tab_name]
	model=model_for_table params[:tab_name]
	@last_links_id=params[:id]
	@column_arr=model.column_names
	table=model.select("#{@column_arr[3]}").where('id='+@last_links_id)
	table.each do |val|
	puts "============Value Is ===================="
	puts val.inspect
	val.attributes.each do |attr_name, attr_value|
 	@item=attr_value
	puts @item.inspect	
	end
	end
	get_table_list?
	@name=model
	@main="active"
	erb:show
end
get '/delete' do
	@tab_name=params[:tab_name]
	model=model_for_table params[:tab_name]
	@last_links_id=params[:id]
	@column_arr=model.column_names
	table=model.select("#{@column_arr[3]}").where('id='+@last_links_id)
	table.each do |val|
	puts "============Value Is ===================="
	puts val.inspect
	val.attributes.each do |attr_name, attr_value|
 	@item=attr_value
	puts @item.inspect	
	end
	end
	get_table_list?
	@name=model
	@main="active"
	erb:delete		
end
get '/edit' do

	@tab_name=params[:tab_name]
	model=model_for_table params[:tab_name]
	@last_links_id=params[:id]
	@column_arr=model.column_names
	@table=model.find(@last_links_id)
	@val=@table
	@val.attributes.each do |attr_name, attr_value|
	puts "#{attr_name}......#{attr_value}" 	
	@item=attr_value
	puts @item.inspect	
	end
	get_table_list?
	@name=model
	@main="active"
	erb:edit


end
get '/history' do
	
	@tab_name=params[:tab_name]
	model=model_for_table params[:tab_name]
	@last_links_id=params[:id]
	@column_arr=model.column_names
	@table=model.find(@last_links_id)
	@val=@table
	@val.attributes.each do |attr_name, attr_value|
	puts "#{attr_name}......#{attr_value}" 	
	@item=attr_value
	puts @item.inspect	
	end
	@history=History.select("id,message,item,username,table_name,created_at,updated_at").where("table_name='"+params[:tab_name]+"' and message='"+@item.to_s+"'")
	puts "============ History is ================="
	puts @history.inspect	
	get_table_list?
	@name=model
	@main="active"
	erb:history

end
#updating database..................
	
post '/update' do 

	@tab_name=params[:tab_name]
	model=model_for_table params[:tab_name]
	@last_links_id=params[:id]
	@column_arr=model.column_names
	params[:req_name].each do |key,value|
	model.find(@last_links_id).update_attributes(key => value)
	puts "Updated Successfully ..."	
	end
	@history=History.new(:message =>params[:item],:username =>session[:uname],:item => 2,:table_name =>params[:tab_name])
	@history.save
	@name=model
	@active="tabbed_list"
	@main="active"
	get_table_list?
	paginate model
	erb:ball
end



post '/deleteitems' do
	@tab_name=params[:tab_name]
	model=model_for_table params[:tab_name]
	@last_links_id=params[:id]
	@column_arr=model.column_names

	model.delete(params[:id])
	@history=History.new(:message =>params[:item],:username =>session[:uname],:item => 3,:table_name =>params[:tab_name])
	@history.save
	@active="tabbed_list"
	@main="active"
	get_table_list?
	paginate model
	erb:ball
	
end
























