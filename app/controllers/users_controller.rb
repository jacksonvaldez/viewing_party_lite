class UsersController < ApplicationController
  def new
  end

  def show
    @user = User.find(params[:id])
    @facade = MovieFacade.new 
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
