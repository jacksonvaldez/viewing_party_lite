class MovieFacade

  def get_movie_by_id(id)
    data = service.movie_id_search(id)
    Movie.new(data)
  end

  def top_rated_movies(pages)
    top_rated_movies = []
    pages.times do |i|
      service.top_rated_movies(i + 1)[:results].map{|data| top_rated_movies << TopRatedMovies.new(data)}
    end
    top_rated_movies
  end

  def search_movies(query)
    service.search_movies(query)[:results].map{|data| SearchMovies.new(data)}
  end
  def service
    @service ||= MovieService.new
  end
end
