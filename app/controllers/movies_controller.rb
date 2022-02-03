class MoviesController < ApplicationController

  def index
    @facade = MovieFacade.new
    if params[:q] == "top_20_rated"
      @movies = @facade.top_rated_movies(2)
    else
      @movies = @facade.search_movies(params[:q])
    end
    @movies.first(40)
  end
  
  def show
    @facade = MovieFacade.new
    @movie = @facade.get_movie_by_id(params[:movie_id])
  end

end
