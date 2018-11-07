class RentalsController < ApplicationController

  def index
    rentals = Rental.all

    render json: jsonify(rentals)
  end

  def checkout
    rental = Rental.new(rental_params)

    movie = rental.movie
    customer = rental.customer
    date = Date.today

    if movie.available_inventory > 0

      movie.available_inventory -= 1
      customer.movies_checked_out_count += 1
      rental.checkout_date = date
      rental.due_date = (date + 7)

      if rental.save && movie.save && customer.save
        render json: { rental_id: rental.id }
      else
        render_error(:not_found, rental.errors.messages)
      end

    else
      render_error(:bad_request ["No rental inventory available for #{movie.title}"])
    end
  end


  def checkin
    customer = Customer.find_by(id: params[:customer_id])
    movie = Movie.find_by(id: params[:movie_id])
    rental = nil
    date = Date.today

    customer.rentals.each do |r|
      if r.movie == movie
        rental = r
      end
    end


    rental.checkin_date = date
    rental.checkout_date = nil
    rental.due_date = nil

    movie.available_inventory += 1
    customer.movies_checked_out_count -= 1

    if rental.save && movie.save && customer.save
      render json: { rental_id: rental.id }
    else
      render_error(:not_found, rental.errors.messages)
    end
  end


  private

  def rental_params
    params.permit(:customer_id, :movie_id)
  end

  def jsonify(rental_data)
    return rental_data.as_json()
  end
end
