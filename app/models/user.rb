class User < ActiveRecord::Base
	attr_accessible :email, :password, :password_confirmation, :name
	has_secure_password
	validates_presence_of :password, :on => :create
	
	has_many :comments, :dependent => :destroy
	has_many :experiences, 	:foreign_key => "joiner_id",
							:dependent => :destroy
	has_many :joined, :through => :experiences, :source => :joined
	has_many :quests
	
	validates  	:email,
				:presence 	=> true,
				:uniqueness => { :case_sensitive => false },
				:format 	=> { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
	
	validates	:name,
				:presence 	=> true,
				:length 	=> { :maximum => 50 }
				
	def feed
		Comment.from_quests_joined_by(self)
	end
	
	def joined?(joined)
		experiences.find_by_joined_id(joined)
	end
	
	def join!(joined)
		experiences.create!(:joined_id => joined.id)
	end
	
	def unjoin!(joined)
		experiences.find_by_joined_id(joined).destroy
	end
	
	def self.user_search(search)
	  if (search != "")
		where 'name LIKE ? OR email LIKE ?', "%#{search}%", "%#{search}%"
	  else
		scoped
	  end
	end

end
