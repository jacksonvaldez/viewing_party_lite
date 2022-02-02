class Movie
  attr_reader :title, :image_url

  def initialize(data)
    @title = data[:title]
    @image_url = data[:poster_path]
  end
end
