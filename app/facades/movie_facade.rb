class MovieFacade

  def top_rated_movies
    service.top_rated_movies[:results].map{|data| TopRatedMovies.new(data)}
  end

  def search_movies
    service.search_movies[:results].map{|data| SearchMovies.new(data)}
  end
  def service
    MovieService.new
  end
end
