class RentalsController < ApplicationController

  # This is a POST verb
  def checkout
    rental = Rental.new(rental_params)

    # check inventory before save
    movie = Movie.find_by(id: :movie_id)

    if movie.available_inventory > 0

      if rental.save
        movie.available_inventory - 1
      else
        render_error(:not_found, rental.errors.messages)
      end
    else
      render_error(:bad_request)
    end

  end

  # This is a POST verb
  def checkin
  end

  private

  def rental_params
    params.permit(:customer_id, :movie_id)
  end


end
