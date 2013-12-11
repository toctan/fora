class UsersController < ApplicationController
  def new
    if session[:omniauth]
      @user = User.new_with_auth_hash(session[:omniauth])
      @user.valid?
    else
      redirect_to root_url
    end
  end

  def create
    @user = User.new_with_auth_hash(session[:omniauth]).tap do |u|
      u.attributes = user_params
    end

    if @user.save
      self.current_user = @user
      redirect_to root_url
    else
      render new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username)
  end
end
