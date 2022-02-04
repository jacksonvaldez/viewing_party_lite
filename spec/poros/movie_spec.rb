require 'rails_helper'

RSpec.describe Movie do

  before(:each) do
    attributes = {
      poster_path: 'A POSTER PATH',
      title: 'A TITLE',
      vote_average: 7.5,
      id: 6,
      genres: [
        {id: 18, name: "Drama"}, {id: 80, name: "Crime"}, {id: 35, name: "Comedy"}
      ],
      runtime: 100,
      overview: 'hoeifwjoirjo2irjhslkdnfladshgfilaesd,mfbwiuebruh'
    }

    @movie = Movie.new(attributes)
  end

  it 'has attributes' do
    expect(@movie.image_url).to eq('A POSTER PATH')
    expect(@movie.title).to eq('A TITLE')
    expect(@movie.vote_average).to eq(7.5)
    expect(@movie.movie_id).to eq(6)
    expect(@movie.genres).to eq([{id: 18, name: "Drama"}, {id: 80, name: "Crime"}, {id: 35, name: "Comedy"}])
    expect(@movie.runtime).to eq(100)
    expect(@movie.summary).to eq('hoeifwjoirjo2irjhslkdnfladshgfilaesd,mfbwiuebruh')
  end

end
