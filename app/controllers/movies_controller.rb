class MoviesController < ApplicationController
  def index
  end 
  def show
    @facade = MovieFacade.new
    @movie = @facade.get_movie_by_id(params[:movie_id])
  end

end
