require 'rails_helper'

RSpec.describe ViewingParty do

  describe 'relationships' do
    it { should belong_to(:user)}
    it { should have_many(:party_users) }
    it { should have_many(:users).through(:party_users) }
  end

end
