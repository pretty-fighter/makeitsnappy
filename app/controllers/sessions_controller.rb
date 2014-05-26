class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(username: params[:session][:username])
  	if user && user.authenticate(params[:session][:password])
      login user
      flash[:success] = 'You have successfully logged in'
      redirect_to root_url
  	else
      flash.now[:error] = 'Your username/password is incorrect'
      render 'new'
  	end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'You have logged-out'
  end
end
