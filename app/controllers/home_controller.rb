class HomeController < ApplicationController
  def index
	@quests = Quest.where("start >= ?", Date.today).order("start ASC").limit(2)
  end

end
