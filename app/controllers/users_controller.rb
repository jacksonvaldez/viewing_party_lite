class UsersController < ApplicationController
  def new
  end

  def show
    @user = User.find_by(id: session[:user_id])
    if @user
      @facade = MovieFacade.new

      @invited_parties = @user.viewing_parties
      @hosted_parties = ViewingParty.where(user_id: @user.id)
    else
      flash[:authorization_error] = "You must login to visit your dashboard"
      redirect_to "/"
    end
  end

  def create
    user = User.new(user_params)

    if user.save
      session[:user_id] = user.id
      redirect_to "/dashboard"
    else
      user.errors.messages.each do |field, error|
        flash[field] = "#{field} #{error.first}"
      end
      redirect_to "/register"
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

end
