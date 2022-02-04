require 'rails_helper'

RSpec.describe CastMember do

  before(:each) do
    attributes = {
      name: "A NAME",
      character: "A FAKE NAME"
    }

    @cast_member = CastMember.new(attributes)
  end

  it 'has attributes' do
    expect(@cast_member.real_name).to eq("A NAME")
    expect(@cast_member.movie_name).to eq("A FAKE NAME")
  end
  
end
