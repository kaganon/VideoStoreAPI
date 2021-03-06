class RentalsController < ApplicationController

  def checkout
    rental = Rental.new(rental_params)

    if rental.is_available?

      rental.update_check_out_date
      rental.update_due_date

      if rental.save
        render json: { rental_id: rental.id }
      else
        render_error(:bad_request, rental.errors.messages)
      end

    else
      render_error(:not_found, { rental_id: ["Cannot checkout movie: no available inventory for checkout"] })
    end
  end


  def checkin
    customer = Customer.find_by(id: params[:customer_id])
    movie = Movie.find_by(id: params[:movie_id])

    if customer && movie

      rental = customer.find_rental(movie)
      rental.update_checkin_date

      if rental.save
        render json: { rental_id: rental.id }
      else
        render_error(:bad_request, rental.errors.messages)
      end

    else
      render_error(:not_found, { rental_id: ["No matching rental found for this customer and movie"] })
    end
  end


  private

  def rental_params
    params.permit(:customer_id, :movie_id)
  end
end
