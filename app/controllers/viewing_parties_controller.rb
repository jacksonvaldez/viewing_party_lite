class ViewingPartiesController < ApplicationController
  def new
    if session[:user_id]
      @facade = MovieFacade.new
      @users = User.where.not(id: session[:user_id])
      @movie = @facade.get_movie_by_id(params[:movie_id])
    else
      flash[:error] = "You must be logged in to create a viewing party"
      redirect_to "/movies/#{params[:movie_id]}"
    end
  end

  def create
    datetime = "#{params[:start_date]} #{params[:start_time]}:00"
    viewing_party = ViewingParty.create(
      user_id: session[:user_id],
      movie_id: params[:movie_id],
      duration: params[:duration],
      start_date: datetime,
    )

    party_goers = params[:usernames]
    party_goers ||= []

    party_goers.each do |user_id, selected|
      if selected == "1"
        PartyUser.create(viewing_party_id: viewing_party.id, user_id: user_id )
      end
    end
    redirect_to "/dashboard"
  end
end
