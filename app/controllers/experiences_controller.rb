class ExperiencesController < ApplicationController
	before_filter :authenticate
	
	def create
		@quest = Quest.find(params[:experience][:joined_id])
		current_user.join!(@quest)
		respond_to do |format|
			format.html { redirect_to @quest }
			format.js
		end
	end
	
	def destroy
		@quest = Experience.find(params[:id]).joined
		current_user.unjoin!(@quest)
		respond_to do |format|
			format.html { redirect_to @quest }
			format.js
		end
	end
	
end
