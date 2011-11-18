class UsersController < ApplicationController
	
	before_filter :authenticate, :except => [:show, :new, :create]
	before_filter :correct_user, :only => [:edit, :update]
	before_filter :admin_user,	 :only => :destroy

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
	@title = "All users"
	@users = User.paginate(:page => params[:page], :per_page => 5, :order => 'id')
	
  end
  
  def show
	@user = User.find(params[:id])
	@active_quests = @user.joined.where("start <= ? AND enddate >= ?", Date.today, Date.today).order("start ASC").paginate(
											:page => params[:apage], :per_page => 3, :order => 'start')
	@upcoming_quests = @user.joined.where("start > ?", Date.today).order("start ASC").paginate(
											:page => params[:upage], :per_page => 3, :order => 'start')
	@completed_quests = @user.joined.where("enddate < ?", Date.today).order("start ASC").paginate(
											:page => params[:cpage], :per_page => 3, :order => 'start')
	@title = @user.name
	@feed_items = @user.feed.paginate(:page => params[:page], :per_page => 10)
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
	
	
  
end
