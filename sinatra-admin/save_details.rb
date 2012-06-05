helpers do 
def model_for_table(table_name)
 	table_name.classify.constantize	
end
end
post '/insert' do 
	
	puts "=======I am in insert BAll ================"
	puts params.inspect
	@tab_name=params[:tab_name]
	model=model_for_table params[:tab_name]
	@column_arr=model.column_names
	model.create(params[:req_name])
	lastid=model.find(:last)
	@last_id=lastid.id.to_s
	@history=History.new(:message =>params[:item],:username =>session[:uname],:item => 1,:table_name =>params[:tab_name])
	@history.save
	if params[:btnname]=="save"
	get_table_list?	
	paginate model
	@active="tabbed_list"
	@main="active"
	erb:ball
	elsif params[:btnname]=="save_another"
	get_table_list?	
	paginate model
	@active="tabbed_new"
	@main="active"
	erb:ball
	elsif params[:btnname]=="save_edit"
	model=model_for_table params[:tab_name]
	@last_links_id=params[:id]
	@column_arr=model.column_names
	@table=model.find(@last_id)
	@val=@table
	@val.attributes.each do |attr_name, attr_value|
	puts "#{attr_name}......#{attr_value}" 	
	@item=attr_value
	puts @item.inspect	
	end
	get_table_list?
	@name=model
	erb:edit
	end
	
end

