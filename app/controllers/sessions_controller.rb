class SessionsController < ApplicationController
  skip_before_action :authorize
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    #write_fragment(user)
    if user and user.authenticate(params[:password]) and user.id == 1
      session[:user_id] = user.id
      redirect_to admin_url
    elsif user and user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to player_url
    else
      redirect_to login_url, alert:"Invalid Username or Password"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_url, alert:"Successfully Logged out"
  end
end
