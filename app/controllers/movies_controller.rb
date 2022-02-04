class MoviesController < ApplicationController

  def index
    # require "pry"; binding.pry
    @facade = MovieFacade.new
    if params[:q] == "top_20_rated"
      @movies = @facade.top_rated_movies(2).first(40)
    elsif params[:q] != "" && params[:q][0] != " "
      @movies = @facade.search_movies(params[:q] ||= "").first(40)
    else
      flash[:alert] = 'Search Cannot Be Blank'
      redirect_to "/users/#{params[:user_id]}/discover"
    end
  end

  def show
    @facade = MovieFacade.new
    @movie = @facade.get_movie_by_id(params[:movie_id])
    @reviews = @facade.reviews(params[:movie_id])
    @cast_members = @facade.movie_cast_members(params[:movie_id]).first(10)
  end

end
