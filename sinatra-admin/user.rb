class UserSession < Authlogic::Session::Base
end
class Ball < ActiveRecord::Base
 attr_accessible :color
 validates_presence_of :color	
end
class Comment < ActiveRecord::Base
	attr_accessible :commentable_id, :commentable_type , :content
	belongs_to :commentable
end


class League < ActiveRecord::Base
	attr_accessible :name , :team_ids, :created_at
	has_many :teams
end


class Player < ActiveRecord::Base     
  belongs_to :team, :inverse_of => :players
  has_many :comments, :as => :commentable
end

class Team < ActiveRecord::Base
  has_many :players
  has_many :comments, :as => :commentable

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
  ActiveRecord::Base.connection.tables	
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
