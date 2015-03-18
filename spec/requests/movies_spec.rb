require 'rails_helper'

describe 'Movies' do

  before do
    @movie = Movie.create!(title: "Birdman", rating: 'r', total_gross: 9_300_000, description: "birdman", released_on: Date.parse("October 17, 2014"))
  end

  it "#index" do
    # Bunch of random movies to check the index action
    1.upto(5) do |i|
      Movie.create(title: "Movie_#{i}", rating: 'r', description: "Movie_#{i} description");
    end

    get '/movies'
    expect(response).to be_success

    json = JSON.parse(response.body)
    movie = json.first
    check_remote_movie(movie)

    expect(json.length).to eq 6
  end

  it "#show" do
    get "/movies/#{@movie.id}"
    expect(response).to be_success

    movie = JSON.parse(response.body)
    check_remote_movie(movie)
  end

  it "#create" do
    post "/movies",
        {movie: {title: "Jaws", description: 'Big shark eats everyone' }}.to_json,
        { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }
    expect(response).to be_success
    expect(response.status).to eq(201)

    updated_movie = Movie.last
    expect(updated_movie.title).to match(/Jaws/)
    expect(updated_movie.description).to match(/shark/)

  end

  let(:ben_hur_params) do
    { movie: {
        title: 'Ben Hur',
        rating: 'pg',
        description: "Roman Era",
        reviews_attributes:
          [
            {name: 'joe smoe', stars: 2, comment: 'too long'},
            {name: 'jill doe', stars: 4, comment: 'nice chariots'}
          ]
      }
    }
  end

  it "#create with reviews" do
    post "/movies",
        ben_hur_params.to_json,
        { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }
    expect(response).to be_success
    expect(response.status).to eq(201)

    new_movie = Movie.last
    expect(new_movie.title).to match(/Ben Hur/)
    expect(new_movie.description).to match(/Roman/)
    expect(new_movie.reviews.count).to eq(2)

    first_review = new_movie.reviews.first
    expect(first_review.name).to eq "joe smoe"
    expect(first_review.stars).to eq 2

    second_review = new_movie.reviews.last
    expect(second_review.name).to eq "jill doe"
    expect(second_review.stars).to eq 4

  end

  it "#update" do
    put "/movies/#{@movie.id}",
        {movie: {description: 'A new description' }}.to_json,
        { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }
    expect(response).to be_success
    expect(response.status).to eq(204)

    updated_movie = Movie.find(@movie.id)
    expect(updated_movie.description).to eq "A new description"

  end

  private

  def check_remote_movie(movie)
    expect(movie['title']).to eq "Birdman"
    expect(movie['total_gross'].to_i).to eq 9_300_000
    expect(movie['rating']).to eq "r"
    expect(movie['released_on']).to eq  Date.parse("October 17, 2014").to_s
    expect(movie['title']).to eq "Birdman"
  end

end
