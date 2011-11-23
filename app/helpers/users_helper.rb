module UsersHelper

  def gravatar_for(user, options = { :size => 50 })
    gravatar_image_tag(user.email.downcase, :alt => user.name,
                                            :class => 'gravatar',
                                            :gravatar => options)
  end
  
  def getpoints(user)
	@points = 0
	@quests = user.joined
	@all_completed_quests = @quests.where("enddate < ?", Date.today)
	@all_completed_quests.each do |cq|
		@points += cq.joiners.count
	end
	return @points
  end

  
end
