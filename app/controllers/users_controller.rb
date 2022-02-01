class UsersController < ApplicationController
  def new
  end

  def show
  end

  def create
    user = User.create(
      username: params[:user][:username],
      email: params[:user][:email],
      password: params[:user][:password]
    )
    redirect_to "/users/#{user.id}"
  end
end
