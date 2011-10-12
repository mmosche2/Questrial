class User < ActiveRecord::Base
	has_secure_password
	validates_presence_of :password, :on => :create
	
	validates  	:email,
				:presence 	=> true,
				:uniqueness => { :case_sensitive => false },
				:format 	=> { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
	
	validates	:name,
				:presence 	=> true,
				:length 	=> { :maximum => 50 }

end
