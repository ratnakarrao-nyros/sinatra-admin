require 'rubygems'
require 'sinatra'
require 'active_record'
require 'pony'
require 'authlogic'
require './user'
require 'yaml'

#Establshing Connection ....
configure do
  use Rack::Session::Pool
  dbconfig = YAML::load(File.open 'config/database.yml')[ Sinatra::Application.environment.to_s ]
  ActiveRecord::Base.establish_connection(dbconfig)
end
class Sinatra::Request
  alias remote_ip ip
end
#creating new user......

Notice = Struct.new(:msg).new

helpers do
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end
  def restrict
    ( notify 'You must be logged in to view that page'; redirect '/login' ) unless current_user
  end
  def notify( msg )
    if Notice.msg.nil? then Notice.msg = msg
    else Notice.msg += '<br/>' + msg
    end
  end
  def notice
    msg = Notice.msg
    Notice.msg = nil; msg
  end

 # Converting table Name to Model Name
	def model_for_table(table_name)
 	table_name.classify.constantize	
	end

	
  #Getting all table list from database

  def get_table_list?
 	 @user=User.new()
	 @table_list=@user.list_tab
  end

 # Deciding Dashboard Lable 
  def label_name count
  
      case count
	when 1..10 
	 "info"
	when 11..20
	 "success"
	when 21..30
	  "warning"
	else
	  "danger"
      end	

  end
   
  def percent (table)
      count=table.new.count_record
      session[table]=label_name count 
      return count 
  end	

  def time (table)
	if table.count > 0
      lasttime=table.new.last_time 
	t = Time.parse(lasttime)-Time.now
	mm, ss = t.divmod(60)           
	hh, mm = mm.divmod(60)           
	dd, hh = hh.divmod(24)          
	puts "%d days, %d hours, %d minutes and %d seconds" % [dd, hh, mm, ss]
	return @day=dd	
	else 
		puts "No Record Found in the database "	
	end
	
  end	
  
  def tab_percent table_list
	@percentage_hash=Hash.new()
	@lastused_hash=Hash.new()
	table_list.each do |table|
		if table=="schema_migrations" or table=="sessions" or table=="users" or table=="histories"
		puts table		
		else
		#Converting table names into Model Names
		model=model_for_table table
		#Calculating percentage for each table to dispaly at dashboard		
		@percentage_hash[table]=percent model		
		#Lastusage of each table				
		@lastused_hash[table]=time model	
		end
	
	end		
   end
end

['signup.rb', 'models.rb','tables.rb','ajax_calls.rb','save_details.rb','extern_files.rb','extern_xml.rb','last_links.rb','filters.rb'].each {|routes_or_classes| load routes_or_classes}

#route path 
get '/'do
	erb:index 
end


