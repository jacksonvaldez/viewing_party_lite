class Movie
  attr_reader :title, :image_url, :vote_average, :movie_id, :genres, :runtime, :summary

  def initialize(data)
    @image_url = data[:poster_path]
    @title = data[:title]
    @vote_average = data[:vote_average]
    @movie_id = data[:id]
    @genres = data[:genres]
    @runtime = data[:runtime]
    @summary = data[:overview]
  end
end
