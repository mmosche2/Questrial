class Comment < ActiveRecord::Base
  belongs_to :quest
  belongs_to :user
  
  validates :body, :presence => true
  validates :quest_id, :presence => true
  
  default_scope :order => 'comments.created_at DESC'
end
