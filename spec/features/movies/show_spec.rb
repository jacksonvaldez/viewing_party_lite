require 'rails_helper'

RSpec.describe "Movie Show/Details Page" do

  before(:each) do
    json_movie_11 = File.read('./spec/fixtures/movie_11.json')
    json_reviews_movie_11 = File.read('./spec/fixtures/reviews_movie_11.json')
    json_credits_movie_11 = File.read('./spec/fixtures/credits_movie_11.json')

    stub_request(:get, "https://api.themoviedb.org/3/movie/11/credits?api_key=#{ENV['movie_api_key']}&language=en-US").
         to_return(status: 200, body: json_credits_movie_11, headers: {})
    stub_request(:get, "https://api.themoviedb.org/3/movie/11/reviews?api_key=#{ENV['movie_api_key']}&language=en-US&page=1").
         to_return(status: 200, body: json_reviews_movie_11, headers: {})
    stub_request(:get, "https://api.themoviedb.org/3/movie/11?api_key=#{ENV['movie_api_key']}&language=en-US").
         to_return(status: 200, body: json_movie_11, headers: {})


    @user = User.create!(username: 'sara', email: 'sara@gmail.com', password: 'helloworld123!!', password_confirmation: 'helloworld123!!')
    @facade = MovieFacade.new
    @movie = @facade.get_movie_by_id(11)
    @reviews = @facade.reviews(11)
    @cast_members = @facade.movie_cast_members(11)

    #login
    visit '/login'
    fill_in(:user_email, with: 'sara@gmail.com')
    fill_in(:user_password, with: 'helloworld123!!')
    click_on "Log In"

    visit ("/movies/#{@movie.movie_id}")
  end

  it 'displays a button to create a viewing party' do
    expect(page).to have_button("Create Viewing Party For #{@movie.title}")
  end

  it 'the button to create a viewing party takes you to correct path' do
    click_on("Create Viewing Party For #{@movie.title}")

    expect(current_path).to eq("/movies/#{@movie.movie_id}/viewing_parties/new")
  end

  it 'displays a button to go to the discover page' do
    expect(page).to have_button("Discover Page")
  end

  it 'the button to go to discover page takes you to correct path' do
    click_on("Discover Page")

    expect(current_path).to eq("/discover")
  end


  it 'displays movie attributes' do
    expect(page).to have_content(@movie.title)
    expect(page).to have_content(@movie.vote_average)
    expect(page).to have_content(@movie.runtime)
    expect(page).to have_content(@movie.genres.first[:name])
    expect(page).to have_content(@movie.summary[0..20])
    expect(page).to have_content(@cast_members.first.real_name)
    expect(page).to have_content(@cast_members.first.movie_name)
    expect(page).to have_content("Reviews (4)")
    expect(page).to have_content(@reviews.first.author)
    expect(page).to have_content(@reviews.first.content[0..20])
  end

  it 'if you click create viewing party button as a visitor, it will say you need to log in to create a viewing party' do
    visit '/'
    click_on 'Log Out'

    visit "/movies/#{@movie.movie_id}"
    click_on("Create Viewing Party For #{@movie.title}")

    expect(current_path).to eq("/movies/#{@movie.movie_id}")
    expect(page).to have_content("You must be logged in to create a viewing party")


  end

end
