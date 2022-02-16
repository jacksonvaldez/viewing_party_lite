require 'rails_helper'

RSpec.describe 'Movies Index/Results Page' do
  before(:each) do
    @user = User.create!(username: 'john', email: 'john@gmail.com', password: 'supersecret', password_confirmation: 'supersecret')

    json_movie_651445 = File.read('./spec/fixtures/movie_651445.json')
    json_movie_730154 = File.read('./spec/fixtures/movie_730154.json')
    json_top_rated_page_1 = File.read('./spec/fixtures/top_rated_page_1.json')
    json_top_rated_page_2 = File.read('./spec/fixtures/top_rated_page_2.json')
    json_movie_search_john_wick = File.read('./spec/fixtures/movie_search_john_wick.json')

    json_credits_movie_730154 = File.read('./spec/fixtures/credits_movie_730154.json')
    json_credits_movie_651445 = File.read('./spec/fixtures/credits_movie_651445.json')
    json_reviews_movie_730154 = File.read('./spec/fixtures/reviews_movie_730154.json')
    json_reviews_movie_651445 = File.read('./spec/fixtures/reviews_movie_651445.json')

    stub_request(:get, "https://api.themoviedb.org/3/movie/651445?api_key=#{ENV['movie_api_key']}&language=en-US").
         to_return(status: 200, body: json_movie_651445, headers: {})
    stub_request(:get, "https://api.themoviedb.org/3/movie/730154?api_key=#{ENV['movie_api_key']}&language=en-US").
         to_return(status: 200, body: json_movie_730154, headers: {})
    stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['movie_api_key']}&language=en-US&page=1").
         to_return(status: 200, body: json_top_rated_page_1, headers: {})
    stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['movie_api_key']}&language=en-US&page=2").
         to_return(status: 200, body: json_top_rated_page_2, headers: {})

    stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['movie_api_key']}&include_adult=false&language=en-US&page=1&query=John%20Wick").
         to_return(status: 200, body: json_movie_search_john_wick, headers: {})

    stub_request(:get, "https://api.themoviedb.org/3/movie/730154/reviews?api_key=#{ENV['movie_api_key']}&language=en-US&page=1").
         to_return(status: 200, body: json_reviews_movie_730154, headers: {})
    stub_request(:get, "https://api.themoviedb.org/3/movie/651445/reviews?api_key=#{ENV['movie_api_key']}&language=en-US&page=1").
         to_return(status: 200, body: json_reviews_movie_651445, headers: {})
    stub_request(:get, "https://api.themoviedb.org/3/movie/730154/credits?api_key=#{ENV['movie_api_key']}&language=en-US").
         to_return(status: 200, body: json_credits_movie_730154, headers: {})
    stub_request(:get, "https://api.themoviedb.org/3/movie/651445/credits?api_key=#{ENV['movie_api_key']}&language=en-US").
         to_return(status: 200, body: json_credits_movie_651445, headers: {})

    visit "/users/#{@user.id}/discover"
  end

  it 'displays a button to take you back to discover page' do
    click_on("Top Rated Movies")

    expect(page).to have_button("Discover Page")
    click_on("Discover Page")

    expect(current_path).to eq("/users/#{@user.id}/discover")
  end

  it 'when you click top rated movies, it displays movie titles and vote averages' do
    click_on("Top Rated Movies")

    within "#movie-730154" do
      expect(page).to have_link("Your Eyes Tell")
      expect(page).to have_content("Vote Average: 8.8")
    end

    within '#movie-19404' do
      expect(page).to have_link("Dilwale Dulhania Le Jayenge")
      expect(page).to have_content("Vote Average: 8.7")
    end

    within '#movie-550' do
      expect(page).to have_link("Fight Club")
      expect(page).to have_content("Vote Average: 8.4")
    end

  end

  it 'when you click Find Movies with a query, it displays movie titles and vote averages' do
    fill_in(:q, with: 'John Wick')
    click_on("Find Movies")

    within "#movie-245891" do
      expect(page).to have_link("John Wick")
      expect(page).to have_content("Vote Average: 7.4")
    end

    within "#movie-651445" do
      expect(page).to have_link("John Wick Chapter 2: Wick-vizzed")
      expect(page).to have_content("Vote Average: 7.6")
    end
  end

  it 'movie links take you to correct path #1' do
    click_on("Top Rated Movies")

    click_on("Your Eyes Tell")
    expect(current_path).to eq("/users/#{@user.id}/movies/730154")
  end

  it 'movie links take you to correct path #2' do
    fill_in(:q, with: 'John Wick')
    click_on("Find Movies")

    click_on("John Wick Chapter 2: Wick-vizzed")
    expect(current_path).to eq("/users/#{@user.id}/movies/651445")
  end

  it 'doesnt allow blank searches for movie search' do
    click_on("Find Movies")

    expect(current_path).to eq("/users/#{@user.id}/discover")
    expect(page).to have_content("Search Cannot Be Blank")
  end
end
