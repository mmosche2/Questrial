class HomeController < ApplicationController
  def index
	@quests = Quest.where("start >= ?", Date.today).order("joiners_count DESC").limit(3)
  end

end
