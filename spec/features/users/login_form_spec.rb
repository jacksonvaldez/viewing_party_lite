require 'rails_helper'

RSpec.describe 'User Login Form' do

  before(:each) do
    @user_1 = User.create!(username: 'username123', email: 'random@gmail.com', password: 'passwordTuring123', password_confirmation: 'passwordTuring123')
    @user_2 = User.create!(username: 'AAAusername123', email: 'AAArandom@gmail.com', password: 'passwordTuring123', password_confirmation: 'passwordTuring123')
    visit '/login'
  end

  it 'displays the fields' do
    expect(page).to have_field(:user_email)
    expect(page).to have_field(:user_password)

    expect(page).to have_button("Log In")
  end

  it 'takes to users to their show page after submitting' do
    fill_in(:user_email, with: 'random@gmail.com')
    fill_in(:user_password, with: 'passwordTuring123')
    click_on "Log In"

    expect(current_path).to eq("/dashboard")
  end

  it 'takes user back to login page with flash message if password is wrong' do
    fill_in(:user_email, with: 'random@gmail.com')
    fill_in(:user_password, with: 'wrong-password')
    click_on "Log In"

    expect(current_path).to eq("/login")
  end
end
