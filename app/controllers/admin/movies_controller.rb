module Admin
  class MoviesController < ::MoviesController

    def destroy
      @movie = Movie.find(movie_delete_params)
      @movie.destroy
    end

    private

    def movie_delete_params
      params.require(:id)
    end

  end
end
