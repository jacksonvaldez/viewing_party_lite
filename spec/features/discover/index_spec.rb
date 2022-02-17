require 'rails_helper'

RSpec.describe "Discover movies index page" do
  before :each do
    @user = User.create(username: "Phil", email: "phil@yahoo.com", password: "5678", password_confirmation: '5678')

    #login
    visit '/login'
    fill_in(:user_email, with: 'phil@yahoo.com')
    fill_in(:user_password, with: '5678')
    click_on "Log In"

    json_top_rated_page_1 = File.read('./spec/fixtures/top_rated_page_1.json')
    json_top_rated_page_2 = File.read('./spec/fixtures/top_rated_page_2.json')
    json_movie_search_john_wick = File.read('./spec/fixtures/movie_search_john_wick.json')

    stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['movie_api_key']}&language=en-US&page=1").
         to_return(status: 200, body: json_top_rated_page_1, headers: {})
    stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['movie_api_key']}&language=en-US&page=2").
         to_return(status: 200, body: json_top_rated_page_2, headers: {})

    stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['movie_api_key']}&include_adult=false&language=en-US&page=1&query=John%20Wick").
         to_return(status: 200, body: json_movie_search_john_wick, headers: {})


    visit "/discover"
  end

  it "displays a button to obtain the top rated movies" do
    expect(page).to have_button("Top Rated Movies")
  end

  it "top rated button takes you to correct path" do
    # save_and_open_page
    click_on "Top Rated Movies"

    expect(current_path).to eq("/movies")
  end

  it "displays a text field and button to search for movies" do
    expect(page).to have_field(:q)
    fill_in :q, with: "John Wick"
    expect(page).to have_button("Find Movies")
  end

  it "find movies button takes you to correct path" do
    fill_in :q, with: "John Wick"
    click_on "Find Movies"

    expect(current_path).to eq("/movies")
  end
end
