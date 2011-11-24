class Comment < ActiveRecord::Base
  belongs_to :quest
  belongs_to :user
  
  validates :body, :presence => true
  validates :quest_id, :presence => true
  
  default_scope :order => 'comments.created_at DESC'
  
  #Return comments from the quests joined by the given user
  scope :from_quests_joined_by, lambda { |user| joined_by(user) }
  

  
  private
  
	#Return an SQL condition for quests joined by the given user.
	#We include the user's own id as well
	def self.joined_by(user)
		#joined_ids = user.joined_ids
		joined_ids = %(SELECT joined_id FROM experiences
						WHERE joiner_id = :user_id)
		where("quest_id IN (#{joined_ids}) OR user_id = :user_id", 
				{ :user_id => user })
	end
	
  
  
end
