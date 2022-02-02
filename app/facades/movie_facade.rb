class MovieFacade

  def get_movie_by_id(id)
    data = service.movie_id_search(id)
    Movie.new(data)
  end

  def top_rated_movies
    service.top_rated_movies[:results].map{|data| TopRatedMovies.new(data)}
  end

  def search_movies(query)
    service.search_movies(query)[:results].map{|data| SearchMovies.new(data)}
  end
  def service
    @service ||= MovieService.new
  end
end
