class SessionsController < ApplicationController
  def new
	@title = "Sign in"
  end
  
  def create
	user = User.find_by_email(params[:email])  
	if user && user.authenticate(params[:password])  
	  session[:user_id] = user.id  
	  redirect_back_or user  
	else  
	  flash.now[:error] = "Invalid email or password"  
	  @title = "Sign in"
	  render "new"  
	end  
  end
  
  def destroy
	session[:user_id] = nil
	flash[:success] = "Logged out!"
	redirect_to root_url
  end
  


end
