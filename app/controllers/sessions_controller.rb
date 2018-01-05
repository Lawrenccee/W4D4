class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to cats_url
    else
      render :new
    end
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:user_name],
      params[:user][:password]
    )

    if @user
      login_user!(@user)
      redirect_to cats_url
    else
      flash.now[:errors] = ["Wrong username and password"]
      render :new
    end
  end

  def destroy
    if current_user
      current_user.reset_session_token!
      session[:session_token]  = nil
    end

    redirect_to cats_url
  end
end
