require 'rails_helper'

RSpec.describe "New User Form" do

  before(:each) do
    visit '/register'
  end

  it 'displays the fields' do
    expect(page).to have_field(:user_username)
    expect(page).to have_field(:user_email)
    expect(page).to have_field(:user_password)

    expect(page).to have_button("Register")
  end

  it 'takes to users show page after submitting' do
    fill_in(:user_username, with: 'john')
    fill_in(:user_email, with: 'john@yahoo.com')
    fill_in(:user_password, with: 'password123')

    click_on "Register"

    added_user = User.where(username: 'john', email: 'john@yahoo.com', user_password: 'password123').first

    expect(current_path).to eq("/users/#{added_user.id}")
  end
end
