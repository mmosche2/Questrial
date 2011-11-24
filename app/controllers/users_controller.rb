class UsersController < ApplicationController
	
	before_filter :authenticate, :except => [:show, :new, :create]
	before_filter :correct_user, :only => [:edit, :update]
	before_filter :admin_user,	 :only => :destroy
	
	require 'will_paginate/array'

  def new
	@title = "Sign up"
	@user = User.new
  end
  
  def create  
    @user = User.new(params[:user])  
    if @user.save  
	  flash[:success] = "Welcome to Questrial!"
	  session[:user_id] = @user.id 
      redirect_to @user 
    else  
      @title = "Sign up"
	  render 'new'
    end  
  end 

  def index
	@title = "Leaderboard"

	if (!params[:search].blank?)
		@users = User.user_search(params[:search])
	else
		@users = User.all
	end
     
	@leaderboard = Array.new
	@leaderboard = getPointLeaders(@users)
	
	@leaderboard = @leaderboard.paginate(:page => params[:page], :per_page => 10)
	
  end
  
  def show
	@user = User.find(params[:id])
	@quests = @user.joined
	
	@active_quests = @quests.where("start <= ? AND enddate >= ?", Date.today, Date.today)
	@active_quests_size = @active_quests.size
	@active_quests = @active_quests.order("start ASC").paginate(
											:page => params[:apage], :per_page => 3, :order => 'start')
											
	@upcoming_quests = @quests.where("start > ?", Date.today)
	@upcoming_quests_size = @upcoming_quests.size
	@upcoming_quests = @upcoming_quests.order("start ASC").paginate(
											:page => params[:upage], :per_page => 3, :order => 'start')
											
	@completed_quests = @quests.where("enddate < ?", Date.today)
	@completed_quests_size = @completed_quests.size
	@completed_quests = @completed_quests.order("start ASC").paginate(
											:page => params[:cpage], :per_page => 3, :order => 'start')
	
	@points = getpoints(@user)
	@points_upcoming = getpoints_upcoming(@user)
	@points_active = getpoints_active(@user)
	
	@title = @user.name
	@feed_items = @user.feed.paginate(:page => params[:page], :per_page => 10).limit(20)
  end
  
  
  def update
	@user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end
  
  def edit
	@title = "Edit user"
  end
  
  def destroy
	@user = User.find(params[:id]).destroy
	flash[:success] = "User deleted."
	redirect_to users_path
  end
  
  def joined
	@title = "Joined"
	@user = User.find(params[:id])
	@quests = @user.joined.paginate(:page => params[:page])
	render 'show_joined'
  end
  
  private
  
	
	def correct_user
		@user = User.find(params[:id])
		redirect_to(root_path) unless current_user?(@user)
	end
	
	def getPointLeaders(users)
		@temp_pointleaders = Array.new
		x=0
		users.each do |u|
			@temp_pointleaders[x] = [u, getpoints(u)]
			x += 1
		end
		@temp_pointleaders.sort! {|a,b| b[1] <=> a[1]}
		return @temp_pointleaders
	end
	
  
end
