class MoviesController < ApplicationController

  def index
    movies = Movie.all

    render json: get_json(movies), status: :ok
  end

  def show
    movie = Movie.find_by(id: params[:id] )
    if movie
      render json: get_json(movie), status: :ok
    else
      render_error(:not_found, { movie_id: ["no such movie exists"] })
    end
  end

  def create
    movie = Movie.new(movie_params)

    if movie.save
      render json: { id: movie.id }, status: :ok
    else
      render_error(:bad_request, movie.errors.messages)
    end
  end

  private

  def movie_params
    # How do I test this?
    params.permit(:title, :overview, :release_date, :inventory)
  end

  def get_json(movie_data)
    # How do I test this?
    return movie_data.as_json(only: [:id, :title, :overview, :release_date, :inventory] )
  end
end
