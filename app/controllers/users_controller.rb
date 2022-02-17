class UsersController < ApplicationController
  def new
  end

  def show
    @user = User.find(params[:id])
    @facade = MovieFacade.new

    @invited_parties = @user.viewing_parties
    @hosted_parties = ViewingParty.where(user_id: @user.id)
  end

  def create
    user = User.new(user_params)

    if user.save
      redirect_to "/users/#{user.id}"
    else
      user.errors.messages.each do |field, error|
        flash[field] = "#{field} #{error.first}"
      end
      redirect_to "/register"
    end
  end

  def login_form

  end

  def login_user
    user = User.find_by(email: params[:user_email])

    if user.class == User
      user = user.authenticate(params[:user_password])
      if user.class == User
        flash[:success] = 'You have successfully logged in'
        redirect_to "/users/#{user.id}"
      else
        flash[:error] = 'invalid credentials'
        redirect_to "/login"
      end
    else
      flash[:error] = 'email not found'
      redirect_to "/login"
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

end
