class CastMember

  attr_reader :real_name, :movie_name

  def initialize(data)
    @real_name = data[:name]
    @movie_name = data[:character]
  end

end
