
post '/filterball'do 
	puts "=========filter ball==========="	
	puts params.inspect
	@tab_name=params[:tab_name]
	begin 	
	params.keys.each do |key|
	if params[key]==params[:tab_name]	
		next
	elsif params[key].blank?
		next	
	else
		if key=="created_at" or key=="updated_at"
		initialize?
		model=model_for_table params[:tab_name]
		@column_arr=model.column_names
	@paginate=model.select("#{@column_arr[0]},#{@column_arr[1]},#{@column_arr[2]},#{@column_arr[3]}").where("DATE_FORMAT(created_at, '%m-%d-%Y')='"+params[key]+"'").paginate(:page => params[:page], :per_page => 5).order('id DESC')		
		elsif key=="query"
		initialize?
		model=model_for_table params[:tab_name]
		str=params[:query].lstrip
		@column_arr=model.column_names
		@paginate=model.select("#{@column_arr[0]},#{@column_arr[1]},#{@column_arr[2]},#{@column_arr[3]}").where("CAST(id AS CHAR)='"+params[:query]+"'  or TRIM(#{@column_arr[3]}) like '"+str+"%' or DATE_FORMAT(created_at, '%m-%d-%y')='"+params[:query]+"' or DATE_FORMAT(updated_at, '%m/%d/%y')='"+params[:query]+"'").paginate(:page => params[:page], :per_page => 5).order('id DESC')

		else 
		initialize?
		model=model_for_table params[:tab_name]
		@column_arr=model.column_names
	@paginate=model.select("#{@column_arr[0]},#{@column_arr[1]},#{@column_arr[2]},#{@column_arr[3]}").where(key+"='"+params[key]+"'").paginate(:page => params[:page], :per_page => 5).order('id DESC')	
		end
		
	end
	end
	rescue 
	puts "NO...."
	end
	@main="active"
	@active="tabbed_list"
	get_table_list?
	model=model_for_table params[:tab_name]
	@column_arr=model.column_names	
	erb:ball
end

