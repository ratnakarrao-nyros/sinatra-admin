require 'builder'
post '/getxml' do
		puts params.inspect
		@qry=""
	headers "Content-Disposition" => "attachment;filename=report.xml", "Content-Type" => "application/xml"
		model=model_for_table params[:tab_name]	
		params[:extern_file].each do|key,val|
		@qry=@qry+","+key	
		end
		@qry.slice!(0)
		
		builder do |xml|
		xml.instruct! :xml, :version => '1.0'
		xml.rss :version => "2.0" do
		xml.channel do
		xml.title "Table Name"
		xml.description model
		xml.link "http:localhost:4567/"
									
		@res=model.select(@qry)
		puts "=======Ball list ==============="		
		puts @res.inspect		
				@res.each do |record|
						xml.item do
						xml.title record.id
						xml.link "http:localhost:4567/"
						record.attributes.each do|attr_name,attr_value| 
						xml.discription attr_value	
						end			    
						end
				end
		end
		end
	
	end
end
