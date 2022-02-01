require 'rails_helper'

RSpec.describe Host do

  describe 'relationships' do
    it { should belong_to(:user) }
  end

end
