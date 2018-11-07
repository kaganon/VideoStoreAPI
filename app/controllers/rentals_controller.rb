class RentalsController < ApplicationController

  # JUST FOR DEBUGGING
  def index
    rentals = Rental.all

    render json: jsonify(rentals)
  end

  def checkout
    rental = Rental.new(rental_params)

    if rental.is_available?

      rental.update_check_out_date
      rental.update_due_date

      if rental.save
        render json: { rental_id: rental.id }
      else
        render_error(:not_found, rental.errors.messages)
      end

    else
      render_error(:bad_request, ["No rental inventory available for #{rental.movie.title}"])
    end
  end

  def checkin
    customer = Customer.find_by(id: params[:customer_id])
    movie = Movie.find_by(id: params[:movie_id])

    rental = customer.find_rental(movie)

    if rental
      rental.update_checkin_date

      if rental.save
        render json: { rental_id: rental.id }
      else
        render_error(:not_found, rental.errors.messages)
      end
    else
      render_error(:bad_request, "No rental associated with #{customer.name} and #{movie.title}")
    end
  end


  private

  def rental_params
    params.permit(:customer_id, :movie_id)
  end

  def jsonify(rental_data)
    return rental_data.as_json(except: [:created_at, :updated_at])
  end

end
