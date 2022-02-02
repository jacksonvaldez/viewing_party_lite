require 'rails_helper'

RSpec.describe "Discover movies index page" do
  before :each do
    @user = User.create(username: "Phil", email: "phil@yahoo.com", password: "5678")
    visit "/users/#{@user.id}/discover"
  end

  it "displays a button to obtain the top rated movies" do
    expect(page).to have_button("Top Rated Movies")
  end

  it "top rated button takes you to correct path" do
    # save_and_open_page
    click_on "Top Rated Movies"

    expect(current_path).to eq("/users/#{@user.id}/movies")
  end

  it "displays a text field and button to search for movies" do
    expect(page).to have_field(:search_query)
    expect(page).to have_button("Find Movies")
  end

  it "find movies button takes you to correct path" do
    fill_in :search_query, with: "John Wick"
    click_on "Find Movies"

    expect(current_path).to eq("/users/#{@user.id}/movies")
  end
end
