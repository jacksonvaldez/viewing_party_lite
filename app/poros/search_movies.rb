class SearchMovies
  attr_reader :title, :vote_average

  def initialize(data)
    movies = data[:results][0]

    @title = movies[:title]
    @vote_average = movies[:vote_average]
  end
end
