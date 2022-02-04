class MovieFacade

  def movie_cast_members(movie_id)
    data = service.movie_cast_members(movie_id)
    data[:cast].map do |cast_data|
      CastMember.new(cast_data)
    end
  end

  def reviews(movie_id)
    data = service.reviews(movie_id)
    data[:results].map do |review_data|
      Review.new(review_data)
    end
  end

  def get_movie_by_id(id)
    data = service.movie_id_search(id)
    Movie.new(data)
  end

  def top_rated_movies(pages)
    top_rated_movies = []
    pages.times do |i|
      service.top_rated_movies(i + 1)[:results].map{|data| top_rated_movies << Movie.new(data)}
    end
    top_rated_movies
  end

  def search_movies(query)
    service.search_movies(query)[:results].map{|data| Movie.new(data)}
  end
  def service
    @service ||= MovieService.new
  end
end
