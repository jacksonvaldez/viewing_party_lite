require 'rails_helper'

RSpec.describe "Welcome Page" do
  before :each do
    visit "/"
  end
  it 'displays the name of the application' do
    expect(page).to have_content("Viewing Party Lite")
  end

  it 'displays a button to create a new user' do
    expect(page).to have_button("Create User")
  end

  it 'the create user button to the correct path' do
    click_on "Create User"

    expect(current_path).to eq("/users/new")
  end

  it 'lists existing users with a link for their dashboard' do
    carol = User.create!(username: "Carol", email: "carol@gmail.com", password_digest: "1234")
    timmy = User.create!(username: "Timmy", email: "timmy@gmail.com", password_digest: "5678")
    visit "/"
    expect(page).to have_link("carol@gmail.com's Dashboard")
    expect(page).to have_link("timmy@gmail.com's Dashboard")

    click_on "carol@gmail.com's Dashboard"

    expect(current_path).to eq("/users/#{carol.id}")
  end

  it 'displays a link at the top to return users back to the landing page' do
    expect(page).to have_link("Home")
    expect("Home").to appear_before("Viewing Party Lite")

    click_on "Home"
    expect(current_path).to eq("/")
  end
end
