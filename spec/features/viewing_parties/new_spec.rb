require 'rails_helper'

RSpec.describe "Viewing Party new page" do
  before(:each) do
    @user = User.create!(username: 'john', email: 'john@gmail.com', password: 'supersecret')
    @user_2 = User.create!(username: 'jeff', email: 'jeff@gmail.com', password: 'supersecret')
    @user_3 = User.create!(username: 'ken', email: 'ken@gmail.com', password: 'supersecret')
    json_movie_11 = File.read('./spec/fixtures/movie_11.json')
    stub_request(:get, "https://api.themoviedb.org/3/movie/11?api_key=#{ENV['movie_api_key']}&language=en-US").
         to_return(status: 200, body: json_movie_11, headers: {})

   visit "/users/#{@user.id}/movies/11/viewing_parties/new"
  end

  it 'displays the movie title' do
    expect(page).to have_content("Star Wars")
  end

  it 'displays a prefilled form field of duration for movie runtime' do
    expect(page).to have_field(:duration, with: 121)
  end

  it 'displays a when field that is selectable for a date' do
    expect(page).to have_selector(:field, :start_date)
  end

  it 'displays a start time field that is selectable for a given time' do
    expect(page).to have_selector(:field, :start_time)
  end

  it 'displays checkboxes next to each existing user in system' do
    expect(page).to have_unchecked_field("usernames[#{@user_2.id}]")
    expect(page).to have_unchecked_field("usernames[#{@user_3.id}]")
  end

  it 'saves viewing party after submitting' do
    fill_in(:duration, with: 200)
    fill_in :start_date, with:'2023/01/01'
    fill_in :start_time, with:'22:00:00'
    check "usernames[#{@user_2.id}]"
    click_on "Create Party"

    expect(current_path).to eq("/users/#{@user.id}")
    expect(page).to have_content("Hosted By: john")
    expect(page).to have_link("Star Wars")
    expect(page).to have_content("1 January 2023,10:00 pm")
    expect(page).to have_content("Hosting")

    expect(page).to have_content('Guest: jeff')
  end

  it 'displays the party on another users dashboard' do
    fill_in(:duration, with: 200)
    fill_in :start_date, with:'2023/01/01'
    fill_in :start_time, with:'22:00:00'
    check "usernames[#{@user_2.id}]"
    click_on "Create Party"

    visit "/users/#{@user_2.id}"
    expect(page).to have_content("Hosted By: john")
    expect(page).to have_link("Star Wars")
    expect(page).to have_content("1 January 2023,10:00 pm")
    expect(page).to have_content("Invited")
    expect(page).to have_content('Guest: jeff')
  end 
end
