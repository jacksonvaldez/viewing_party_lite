require 'rails_helper'

RSpec.describe MovieFacade do
  before(:each) do

    @facade = MovieFacade.new
    json_top_rated_page_1 = File.read('./spec/fixtures/top_rated_page_1.json')
    json_movie_search_john_wick = File.read('./spec/fixtures/movie_search_john_wick.json')
    json_movie_2 = File.read('./spec/fixtures/movie_2.json')
    json_reviews_movie_11 = File.read('./spec/fixtures/reviews_movie_11.json')
    json_credits_movie_11 = File.read('./spec/fixtures/credits_movie_11.json')

    stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['movie_api_key']}&language=en-US&page=1").
         to_return(status: 200, body: json_top_rated_page_1, headers: {})
    stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['movie_api_key']}&include_adult=false&language=en-US&page=1&query=John%20Wick").
         to_return(status: 200, body: json_movie_search_john_wick, headers: {})
    stub_request(:get, "https://api.themoviedb.org/3/movie/2?api_key=#{ENV['movie_api_key']}&language=en-US").
         to_return(status: 200, body: json_movie_2, headers: {})
    stub_request(:get, "https://api.themoviedb.org/3/movie/11/credits?api_key=#{ENV['movie_api_key']}&language=en-US").
         to_return(status: 200, body: json_credits_movie_11, headers: {})
    stub_request(:get, "https://api.themoviedb.org/3/movie/11/reviews?api_key=#{ENV['movie_api_key']}&language=en-US&page=1").
         to_return(status: 200, body: json_reviews_movie_11, headers: {})
  end

  describe '#movie_cast_members' do
    it 'returns an array of cast members for a movie' do
      cast_members = @facade.movie_cast_members(11)

      expect(cast_members).to be_a(Array)
      expect(cast_members.first).to be_a(CastMember)
      expect(cast_members.first.real_name).to eq("Mark Hamill")
    end
  end

  describe '#reviews' do
    it 'returns an array of reviews for a movie' do
      reviews = @facade.reviews(11)

      expect(reviews).to be_a(Array)
      expect(reviews.first).to be_a(Review)
      expect(reviews.first.author).to eq("Cat Ellington")

    end
  end

  describe '#get_movie_by_id' do
    it 'returns the correct movie' do
      movie = @facade.get_movie_by_id(2)
      expect(movie).to be_a(Movie)
      expect(movie.title).to eq "Ariel"
    end
  end

  describe '#top_rated_movies' do
    it 'returns the top rated movies' do
      movies = @facade.top_rated_movies(1)
      movies = @facade.top_rated_movies(1) # Repeated because we are testing that it doesnt hit the same endpoint twice
      expect(movies).to be_a(Array)
      expect(movies.first).to be_a(Movie)
      expect(movies.first.title).to eq "Your Eyes Tell"
    end
  end

  describe '#search_movies' do
    it 'returns the movies related to the search' do
      movies = @facade.search_movies("John Wick")
      expect(movies).to be_a(Array)
      expect(movies.first).to be_a(Movie)
      expect(movies.last.title).to eq "John Wick: Calling in the Cavalry"
    end
  end

  describe '#service' do
    it 'returns an instance of MovieService' do
      expect(@facade.service.class).to eq MovieService
    end
  end
end
