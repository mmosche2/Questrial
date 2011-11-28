class Experience < ActiveRecord::Base
	attr_accessible :joined_id, :startdate, :enddate
	
	belongs_to :joiner, :class_name => "User"
	belongs_to :joined, :class_name => "Quest", :counter_cache => :joiners_count
	
	validates :joiner_id, :presence => true
	validates :joined_id, :presence => true
end
