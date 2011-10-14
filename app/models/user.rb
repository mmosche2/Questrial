class User < ActiveRecord::Base
	attr_accessible :email, :password, :password_confirmation, :name
	has_secure_password
	validates_presence_of :password, :on => :create
	
	has_many :comments, :dependent => :destroy
	
	validates  	:email,
				:presence 	=> true,
				:uniqueness => { :case_sensitive => false },
				:format 	=> { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
	
	validates	:name,
				:presence 	=> true,
				:length 	=> { :maximum => 50 }
				
	def feed
		Comment.where("user_id = ?", id)
	end

end
