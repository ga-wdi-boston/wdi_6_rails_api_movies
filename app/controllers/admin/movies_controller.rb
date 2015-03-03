module Admin
  class MoviesController < ::MoviesController

    def destroy
      @movie = Movie.find(params[:id])
      @movie.destroy
    end
  end
end
