require 'rails_helper'

RSpec.describe MovieService do
  before(:each) do
    @service = MovieService.new
  end

  it 'has attributes' do
    expect(@service.request_urls).to eq({})
    expect(@service.api_key).to eq(ENV['movie_api_key'])
  end
end
