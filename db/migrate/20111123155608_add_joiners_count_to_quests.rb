class AddJoinersCountToQuests < ActiveRecord::Migration
  def self.up
	add_column :quests, :joiners_count, :integer, :default => 0
	
	Quest.reset_column_information
	Quest.all.each do |q|
		q.update_attribute :joiners_count, q.joiners.length
	end
  end
  
  def self.down
	remove_column :quests, :joiners_count
  end
end
