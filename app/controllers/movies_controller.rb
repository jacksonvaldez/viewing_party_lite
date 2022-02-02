class MoviesController < ApplicationController
  def show
    @facade = MovieFacade.new
    @movie = @facade.get_movie_by_id(params[:movie_id])
  end
end
