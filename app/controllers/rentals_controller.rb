class RentalsController < ApplicationController

  # This is a POST verb
  def checkout
    rental = Rental.new(rental_params)
    if rental.save
      date = Date.today
      rental.checkout_date = date
      rental.due_date = (date + 7)
      movie = Movie.find_by(id: rental.movie_id)
      rental.movie_inventory(movie)

      render json: { customer_id: :customer_id}

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
