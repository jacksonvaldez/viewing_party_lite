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
    user = User.new(
      username: params[:user][:username],
      email: params[:user][:email],
      password: params[:user][:password],
      password_confirmation: params[:user][:password_confirmation]
    )

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
        redirect_to "/users/#{user.id}"
      else
        redirect_to "/login"
      end
    else
      redirect_to "/login"
    end
  end

end
