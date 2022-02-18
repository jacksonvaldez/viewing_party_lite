class SessionController < ApplicationController

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

  def logout
    session.destroy
    redirect_to "/"
  end

end
