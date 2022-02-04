require 'rails_helper'

RSpec.describe Review do

  before(:each) do
    attributes = {
      author: "A REVIEW AUTHOR",
      content: "A REVIEWS CONTENT"
    }

    @review = Review.new(attributes)
  end

  it 'has attributes' do
    expect(@review.author).to eq("A REVIEW AUTHOR")
    expect(@review.content).to eq("A REVIEWS CONTENT")
  end

end
