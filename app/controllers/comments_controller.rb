class CommentsController < ApplicationController

  before_filter :authenticate, :only => [:create, :destroy]
  before_filter :authorized_user, :only => :destroy

  def create
    @quest = Quest.find(params[:quest_id])
    @comment = @quest.comments.create(params[:comment])
	@comment.user_id = current_user.id
	if @comment.save
		flash[:success] = "Comment posted!"
		redirect_to quest_path(@quest)
	else
		@feed_items = []
		redirect_to quest_path(@quest)
	end
  end
  
  
  def destroy
    @quest = Quest.find(params[:quest_id])
    @comment = @quest.comments.find(params[:id])
    @comment.destroy
    redirect_to :back
  end
  
  private
  
	def authorized_user
		@comment = current_user.comments.find_by_id(params[:id])
		redirect_to quest_path(@quest) if @comment.nil?
	end
  
end
