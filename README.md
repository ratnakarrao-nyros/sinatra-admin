1.ABOUT THIS APPLICATION:
========================
  Sinatra Admin

SinatraAdmin  provides an easy-to-use interface for managing your data.

Features
----------
    Display database tables
    
    Create new data
    
    Easily update data
    
    Safely delete data
    
    Custom actions
    
    Search and filtering
    
    Export data to CSV/JSON/XML
    
    Authentication (via Authlogic)
    
    User action history 
    
    Supported ORMs
    
        ActiveRecord
       
2.INSTALLATION:

==============

Sinatra is a DSL for quickly creating web applications in Ruby with minimal
effort:

# myapp.rb

  require 'sinatra'

  get '/' do
  
    'Hello world!'
    
  end

Install the gem and run with:

  gem install sinatra
  
  ruby -rubygems myapp.rb

View at: http://localhost:4567


== Routes

In Sinatra, a route is an HTTP method paired with a URL-matching pattern.

Each route is associated with a block:

  get '/' do
  
    .. show something ..
    
  end

  post '/' do
  
    .. create something ..
    
  end

  put '/' do
  
    .. replace something ..
    
  end

  patch '/' do
  
    .. modify something ..
    
  end

  delete '/' do
  
    .. annihilate something ..
    
  end

  options '/' do
  
    .. appease something ..
    
  end

Routes are matched in the order they are defined. The first route that

matches the request is invoked.

== Views / Templates

Each template language is exposed as via its own rendering method. These

methods simply return a string:

  get '/' do
  
    erb :index
    
  end

This renders <tt>views/index.erb</tt>.

Instead of a template name, you can also just pass in the template content

directly:

  get '/' do
  
    code = "<%= Time.now %>"
    
    erb code
    
  end

Templates take a second argument, the options hash:


  get '/' do
  
    erb :index, :layout => :post
    
  end


== Database

 	
 ->In this application we used mysql ,also you can connect this app with any of the Database like Sqlite3
 
      
	development: 
	
	  adapter: mysql
	  
	  encoding: utf8
	  
	  database: sinatra_admin
	  
	  username: root
	  
	  password: root
	  
	  host: localhost
	  
	  port: 3306
	  
	  reconnect: true

 ->In config/database.yml file change "adapter" as appropriate with your database.
 
ORM:

 ->For data retriving here this Sinatra app using  "ActiveRecord" , it also supports "Datamapper", "sequel" 

 -> to install activerecord ,type the following command at your terminal
	
	$ sudo gem install activerecord

 -> this app uses sinatra-activerecord for retriving data 
	
	$ gem install sinatra-activerecord

3.REQUIREMENTS:

==============

 Sinatra 1.2.7 and higer, Ruby 1.8.7 versions and higher.


4.WHAT THIS APPLICATION CONTAINS:

================================

1.index.erb	: It contains SignIn , SignUp and ResetPassword with jquery validations.

2.startup.rb	: It contains Helper methods for validating users and for storing session information , and also 

methods to establish the connection to Database

3.signup.rb 	: It contains signup ,signin  process routes

4.models.rb	: It contains all information about our Models

  
             to work with this app ...
             
			when you add new tables to the database just define the following methods in your Model class 

	Example :-

	class ModelName < ActiveRecord::Base

	def count_record
	
	  Model.count
	  
	end
	
	def last_time
	
	  Model.find(:last).created_at.strftime("%H")
	  
  	end
	
	end 
         
5.filter.rb 	  : It contains all information about filtering processing

6.extern_files.rb : It contains all information to export files as json and csv format

7.extern_xml.rb	  : It contains all information to export files as xml format

8.for pagination in this application we used bootstrap will_paginate gem 
	
		$ gem install will_paginate-bootstrap 



Db Migrations Using Rakefile

=============================

	with sinatra you can deal with database by running rake very easily ...
	
	for creating database
  
           $ rake db:create

	it creates a new folder for our application like db/migrate

	for creating migrations
 	
	   $ rake db:create_migrarion NAME= your_migration_name

	for migrating tables into database

	   $ rake db:migrate

 Refer Rakefile for full information about rake
 
 
 
 Screenshots
 ================================
 
 <p>
 <img style="max-width:100%;" title="dashboard view" alt="Dashboard view" src="https://github.com/ratnakarrao-nyros/sinatra-admin/raw/master/screenshots/index.png">
 </p>
 <p>
 <img style="max-width:100%;" title="dashboard view" alt="Dashboard view" src="https://github.com/ratnakarrao-nyros/sinatra-admin/raw/master/screenshots/dashboard.png">
 </p>
 <p>
 <img style="max-width:100%;" title="dashboard view" alt="Dashboard view" src="https://github.com/ratnakarrao-nyros/sinatra-admin/raw/master/screenshots/list.png">
 </p>
 <p>
 <img style="max-width:100%;" title="dashboard view" alt="Dashboard view" src="https://github.com/ratnakarrao-nyros/sinatra-admin/raw/master/screenshots/addnew.png">
 </p>
 <p>
 <img style="max-width:100%;" title="dashboard view" alt="Dashboard view" src="https://github.com/ratnakarrao-nyros/sinatra-admin/raw/master/screenshots/show.png">
 </p>
 <p>
 <img style="max-width:100%;" title="dashboard view" alt="Dashboard view" src="https://github.com/ratnakarrao-nyros/sinatra-admin/raw/master/screenshots/addnew.png">
 </p>
 <p>
 <img style="max-width:100%;" title="dashboard view" alt="Dashboard view" src="https://github.com/ratnakarrao-nyros/sinatra-admin/raw/master/screenshots/paginate.png">
 </p>

  














