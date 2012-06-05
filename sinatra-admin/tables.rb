require "will_paginate/bootstrap"


helpers do

# Convertin table name to Model
def model_for_table(table_name)
 	table_name.classify.constantize	
end

def initialize?
get_table_list?
@active=params[:name]
@main=params[:main]
@status=params[:status]
end
# For Pagination Effect Using will_paginate with twitter bootstrap

def paginate model
@column_arr=model.column_names
@paginate=model.select("#{@column_arr[0]},#{@column_arr[1]},#{@column_arr[2]},#{@column_arr[3]}").paginate(:page => params[:page], :per_page => 5).order('id DESC')
@paginate.each_with_index do |item,index|
item.attributes.each do |attr_name, attr_value|
puts "#{attr_name} ......#{attr_value}"
end

end
end
end



get '/tables' do	
initialize?
model=model_for_table params[:tab_name]
if model==History
@paginate=model.select("id,message,item,username,table_name,created_at,updated_at").where("table_name='"+params[:tab_name]+"'").paginate(:page => params[:page], :per_page => 5).order('id DESC')
else
paginate model
@tab_name=params[:tab_name]
end
erb:ball
end















