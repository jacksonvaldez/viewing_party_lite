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

  def logout
    session.destroy
    redirect_to "/"
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

  def login_form

  end

  def login_user
    user = User.find_by(email: params[:user_email])

    # save_and_open_page
    if user && user.authenticate(params[:user_password])
      session[:user_id] = user.id
      flash[:success] = 'You have successfully logged in'
      redirect_to "/dashboard"
    else
      flash[:error] = 'invalid credentials'
      redirect_to "/login"
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

end
