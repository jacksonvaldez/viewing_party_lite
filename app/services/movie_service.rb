class MovieService

  def search_movies(query)
    api_key = ENV['movie_api_key']
    get_url("search/movie?api_key=#{api_key}&language=en-US&query=#{query}&page=1&include_adult=false")
  end

  def top_rated_movies
    api_key = ENV['movie_api_key']
    get_url("movie/top_rated?api_key=#{api_key}&language=en-US&page=1")
  end

  def get_url(url)
    response = Faraday.get("https://api.themoviedb.org/3/#{url}")
    parsed = JSON.parse(response.body, symbolize_names: true)
  end
end
