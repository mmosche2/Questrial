module UsersHelper

  def gravatar_for(user, options = { :size => 50 })
    gravatar_image_tag(user.email.downcase, :alt => user.name,
                                            :class => 'gravatar',
                                            :gravatar => options)
  end
  
  def getpoints(user)
	points = 0
	quests = user.joined
	all_completed_quests = quests.where("enddate < ?", Date.today)
	all_completed_quests.each do |cq|
		points += cq.joiners.size
	end
	return points
  end
  
  def getpoints_upcoming(user)
	points = 0
	quests = user.joined
	all_upcoming_quests = quests.where("start > ?", Date.today)
	all_upcoming_quests.each do |cq|
		points += cq.joiners.size
	end
	return points
  end
  
  def getpoints_active(user)
	points = 0
	quests = user.joined
	all_active_quests = quests.where("start <= ? AND enddate >= ?", Date.today, Date.today)
	all_active_quests.each do |cq|
		points += cq.joiners.size
	end
	return points
  end
  
end
