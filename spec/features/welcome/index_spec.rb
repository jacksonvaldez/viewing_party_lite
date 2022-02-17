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
    # binding.pry
    expect(current_path).to eq("/register")
  end

  it 'displays a link to login as an existing user' do
    expect(page).to have_link("Log In")
  end

  it 'the login link takes user to correct path' do
    click_on "Log In"
    # binding.pry
    expect(current_path).to eq("/login")
  end

  it 'lists existing users email addresses if user is logged in' do
    carol = User.create!(username: "Carol", email: "carol@gmail.com", password: "1234", password_confirmation: '1234')
    timmy = User.create!(username: "Timmy", email: "timmy@gmail.com", password: "5678", password_confirmation: '5678')
    john = User.create!(username: "John", email: "john@gmail.com", password: "1234", password_confirmation: '1234')
    visit "/"
    
    expect(page).to_not have_content("carol@gmail.com")
    expect(page).to_not have_content("timmy@gmail.com")

    #login
    visit '/login'
    fill_in(:user_email, with: 'john@gmail.com')
    fill_in(:user_password, with: '1234')
    click_on "Log In"
    visit '/'
    expect(page).to have_content("carol@gmail.com")
    expect(page).to have_content("timmy@gmail.com")
  end

  it 'displays a link at the top to return users back to the landing page' do
    expect(page).to have_link("Home")
    expect("Home").to appear_before("Viewing Party Lite")

    click_on "Home"
    expect(current_path).to eq("/")
  end

  it 'doesnt show Log In link or Create User as a loggen in user' do
    carol = User.create!(username: "Carol", email: "carol@gmail.com", password: "1234", password_confirmation: '1234')
    #login
    visit '/login'
    fill_in(:user_email, with: 'carol@gmail.com')
    fill_in(:user_password, with: '1234')
    click_on "Log In"
    visit '/'

    expect(page).to_not have_button("Create User")
    expect(page).to_not have_link("Log In")

    expect(page).to have_link("Log Out")
  end

  it 'the logout button takes you to correct path' do
    carol = User.create!(username: "Carol", email: "carol@gmail.com", password: "1234", password_confirmation: '1234')
    #login
    visit '/login'
    fill_in(:user_email, with: 'carol@gmail.com')
    fill_in(:user_password, with: '1234')
    click_on "Log In"
    visit '/'

    click_on("Log Out")

    expect(current_path).to eq("/")

    expect(page).to have_button("Create User")
    expect(page).to have_link("Log In")

    expect(page).to_not have_link("Log Out")
  end
end
