require 'rails_helper'

describe 'Movies' do
  before do
    @movie = Movie.create!(title: "Birdman", rating: 'r', total_gross: 9_300_000, description: "birdman", released_on: Date.parse("October 17, 2014"))
    1.upto(5) do |i|
      Movie.create(title: "Movie_#{i}", rating: 'r', description: "Movie_#{i} description");
    end
  end

  it "#index" do
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

  it "#update" do
    put "/movies/#{@movie.id}",
        {movie: {description: 'A new description' }}.to_json,
        { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }
    expect(response).to be_success
    expect(response.status).to eq(204)

    updated_movie = Movie.find(@movie.id)
    expect(updated_movie.description).to eq "A new description"

  end

  it "#destroy" do
    delete "/movies/#{@movie.id}"
    expect(response.status).to eq(200)
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
