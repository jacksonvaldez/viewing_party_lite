class MovieService

  def initialize
    @request_urls = {}
    @api_key = ENV['movie_api_key']
  end

  def movie_cast_members(movie_id)
    get_url("movie/#{movie_id}/credits?api_key=#{@api_key}&language=en-US")
  end

  def reviews(movie_id)
    get_url("movie/#{movie_id}/reviews?api_key=#{@api_key}&language=en-US&page=1")
  end

  def movie_id_search(id)
    get_url("movie/#{id}?api_key=#{@api_key}&language=en-US")
  end

  def search_movies(query)
    get_url("search/movie?api_key=#{@api_key}&language=en-US&query=#{query}&page=1&include_adult=false")
  end

  def top_rated_movies(page)
    get_url("movie/top_rated?api_key=#{@api_key}&language=en-US&page=#{page}")
  end

  def get_url(url)
    # response = Faraday.get("https://api.themoviedb.org/3/#{url}")
    # parsed = JSON.parse(response.body, symbolize_names: true)
    if @request_urls[url].nil?
      response = Faraday.get("https://api.themoviedb.org/3/#{url}")
      @request_urls[url] = JSON.parse(response.body, symbolize_names: true)
    else
      @request_urls[url]
    end
  end
end
