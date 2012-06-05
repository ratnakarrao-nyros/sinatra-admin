require "will_paginate/bootstrap"

get '/dboard_home'do
	@table_list=get_table_list?
	tab_percent @table_list	
	session[:team_names]=Team.select("name,id")
	@history=History.paginate(:page =>params[:page], :per_page =>8).order('id DESC')
	erb:dashboard_home
end

post '/register' do
  @user = User.new(:password=> params[:password]  ,
				    :password_confirmation => params[:cpassword] , 
				    :email => params[:email])
 	@user.active = true	
	@a={"email"=>@user.email,"password"=>@user.password}
	@user_session=UserSession.new(@a)
	@user_session.save	
	if @user.save    
	@user_session.save
	@name=@user.email
	session[:uname]=@user_session.email
	redirect '/dboard_home'
    	else
      	notify "Activation did not succeed. Do the passwords match? Are they 6 or more characters long?"
     	redirect '/'
    	end
end


post '/signin' do 
	@a={"email"=>params[:email],"password"=>params[:password]}
	@user_session=UserSession.new(@a)
	session[:uname]=@user_session.email
	@user=User.new()	
	if @user_session.save
	redirect '/dboard_home'
	else
	redirect '/'	
	end
end
get '/signin' do
	@history=History.paginate(:page =>params[:page], :per_page =>8)
	redirect '/dboard_home'
end

post '/reset' do
	if @reset=User.find(:first,:conditions =>{:email => params[:email]})
	puts "----------------------------"	
	puts @reset.inspect	
	@reset.send_password_reset_email
	notify "The email to reset your password has been sent. Pls check your mail."
	redirect '/'	
	else
	notify "No account with email #{params[:email]} was found in our records. Make sure the
email is correct."
	redirect '/'
	end		
end

get '/logout' do
  current_user_session.destroy
  session[:uname]=nil
 notify "You logged out!"
  redirect '/'
end



