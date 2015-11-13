class MoviesController < ApplicationController

  def query
    # /movies/q/title/Jaws/description/shark
    # => params[:specs]
    # title/Jaws/description/shark
    # => String#split
    # ['title','Jaws','description', 'shark']
    # => Hash['title','Jaws','description', 'shark']
    @movies = Movie.where(Hash[*params[:specs].split("/")])
    if @movies.empty?
      head :no_content
    else
      render json: @movies
    end
  end

  def index
    @movies = Movie.all
    render json: @movies
  end

  def show
    @movie = Movie.find(params[:id])
    render json: @movie
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      render json: @movie, status: :created, location: @movie
    else
      render json: @movie.errors, status: :unprocessable_entity
    end
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      head :no_content
    else
      render json: @movie.errors, status: :unprocessable_entity
    end
  end

  protected

  # this method will also be used by subclasses
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :total_gross, :released_on, reviews_attributes: [:name, :stars, :comment])
  end

end
