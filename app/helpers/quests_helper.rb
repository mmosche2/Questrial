module QuestsHelper

  	def get_status(quest)
		if Date.today >= quest.start && Date.today <= quest.enddate
			return "Active"
		elsif Date.today < quest.start
			return "Upcoming"
		elsif Date.today > quest.enddate
			return "Completed"
		end
	end
	
end
