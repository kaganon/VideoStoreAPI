class RentalsController < ApplicationController

  # This is a POST verb
  def checkout
    rental = Rental.new(rental_params)



  end

  # This is a POST verb
  def checkin
  end

  private

  def rental_params
    params.permit(:customer_id, :movie_id)
  end
end
