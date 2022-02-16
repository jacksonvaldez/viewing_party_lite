require 'rails_helper'

RSpec.describe User do

  describe 'relationships' do
    it { should have_many(:party_users) }
    it { should have_many(:viewing_parties).through(:party_users) }

    it { should validate_presence_of(:username)}
    it { should validate_uniqueness_of(:username)}
    it { should validate_presence_of(:email)}
    it { should validate_uniqueness_of(:email)}
    it { should validate_presence_of(:password)}
    it { should validate_presence_of(:password_confirmation)}
    it { should validate_presence_of(:password_digest)}
    it { should have_secure_password}
  end

  it 'stores the password as a hash(bcrypt hash, not ruby hash)' do
    user = User.create!(username: 'name', email: 'email', password: 'password123', password_confirmation: 'password123')

    expect(user.password_digest).to be_a(String)
    expect(user.password_digest).to_not eq('password123')
  end

end
