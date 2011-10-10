class CommentsController < ApplicationController

  http_basic_authenticate_with :name => "quest", :password => "quest", :only => :destroy

  def create
    @quest = Quest.find(params[:quest_id])
    @comment = @quest.comments.create(params[:comment])
    redirect_to quest_path(@quest)
  end
  
  def destroy
    @quest = Quest.find(params[:quest_id])
    @comment = @quest.comments.find(params[:id])
    @comment.destroy
    redirect_to quest_path(@quest)
  end
  
end
