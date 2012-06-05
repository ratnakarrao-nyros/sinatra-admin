class UserSession < Authlogic::Session::Base
end
class Ball < ActiveRecord::Base
 attr_accessible :color
 validates_presence_of :color
  def to_param
    color.present? ? color.downcase.gsub(" ", "-") : id
  end	
  def count_record
  Ball.count	
  end
  
  def last_time  
	Ball.find(:last).created_at.strftime("%H")
  end

	


	has_many :histories, :dependent => :destroy	
end

class Comment < ActiveRecord::Base
	attr_accessible :commentable_id, :commentable_type , :content
	belongs_to :commentable

	def count_record
	  Comment.count	
	end

	def last_time
	Comment.find(:last).created_at.strftime("%H")
  	end

	
	
	has_many :histories, :dependent => :destroy
end


class League < ActiveRecord::Base
	attr_accessible :name , :team_ids, :created_at
	has_many :teams

	def count_record
	  League.count	
	end

	def last_time
	League.find(:last).created_at.strftime("%H")
  	end

	
	
	has_many :histories, :dependent => :destroy
end


class Player < ActiveRecord::Base     
  belongs_to :team, :inverse_of => :players
  has_many :comments, :as => :commentable

	def count_record
	  Player.count	
	end
	
	def last_time
	puts '=============player time is ==========='
	t=Player.find(:last).created_at.strftime("%H")
	puts t.inspect  
	t	
	end

	
	
	has_many :histories, :dependent => :destroy
end

class Team < ActiveRecord::Base
  has_many :players, :as => :team
  has_many :comments, :as => :commentable

	def count_record
	  Team.count	
	end
	def last_time
	Team.find(:last).created_at.strftime("%H")
  	end
	has_many :histories, :dependent => :destroy

end


class Newteam < ActiveRecord::Base

	def count_record
	  Newteam.count	
	end
	def last_time
	Newteam.find(:last).created_at.strftime("%H")
  	end


end

class Employee < ActiveRecord::Base

	def count_record
	  Employee.count	
	end
	def last_time
	  Employee.find(:last).created_at.strftime("%H")
  	end


end
class Student < ActiveRecord::Base

	def count_record
	  Student.count	
	end
	def last_time
	  Student.find(:last).created_at.strftime("%H")
  	end


end

class History < ActiveRecord::Base
  has_many :players, :as => :team
  has_many :comments, :as => :commentable
	def count_record
	  Player.count	
	end
end


class User < ActiveRecord::Base  
configure do
    use Rack::Session::Pool
	end
 acts_as_authentic do |c|
    c.perishable_token_valid_for( 24*60*60 )
    c.validates_length_of_password_field_options =
     {:on => :update, :minimum => 6, :if => :has_no_credentials?}
    c.validates_length_of_password_confirmation_field_options =
     {:on => :update, :minimum => 6, :if => :has_no_credentials?}
  end
  
  def active?
    active
  end

  def list_tab
  tables=ActiveRecord::Base.connection.tables	
  tables.each do |table| 
      puts table	
  end
  return tables
  end  
 
  def send_password_reset_email
    Pony.mail(
      :to => self.email,
      :from => "ratna.v143@gmail.com",
      :subject => "your forgotten password is",
      :body => "We have recieved a request to your password.#{self.password} " 
              
	 )
	puts "Password Has Been sent .........."
  end
end
