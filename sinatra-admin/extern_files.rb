
def csv_output(table,extern_file_params)	
		@qry=""		
		extern_file_params.each do|key,val|
		puts key.inspect
		@qry=@qry+","+key	
		end		
		puts "=========Query Is ==========="
		@qry.slice!(0)
		puts @qry
 		result=table.select(@qry)
 		csv_string = CSV.generate do |csv|
		#header row output page of calls
	 	csv << [@qry]    
		result.each do |res|
			csvqry=""			
			res.attributes.each do |attr_name,attr_value|
			csvqry=csvqry+","+attr_value.to_s					
			end
			csvqry.slice!(0)
			csv << [csvqry]
  	                end
		end
		csv_string
		
end


post '/getcsv' do
	headers "Content-Disposition" => "attachment;filename=report.csv", "Content-Type" => "application/octet-stream"
	puts "==========CSV Params ==========="
	puts params.inspect
	model=model_for_table params[:tab_name]
	puts model
	params.keys.each do |key|
	puts "#{key} -----#{params[key]}"
	if key=="tab_name"
	next
	elsif key=="csv" or key=="json" or key=="xml"
	next
	else
	@csvstring=csv_output(model,params[:extern_file])	
	end
	end  
	@csvstring	
end


post '/getjson' do
	puts "==============param json values==============="
	puts params.inspect
    headers "Content-Disposition" => "attachment;filename=report.json", "Content-Type" => "application/octet-stream"	
	model=model_for_table params[:tab_name]
	puts model
	params.keys.each do |key|
	puts "#{key} -----#{params[key]}"
	if key=="tab_name"
	next
	elsif key=="csv" or key=="json" or key=="xml"
	next
	else
	@csvstring=csv_output(model,params[:extern_file])	
	end
	end  
	@csvstring	

end









