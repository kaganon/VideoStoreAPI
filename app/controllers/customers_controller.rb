class CustomersController < ApplicationController

  def index
    customers = Customer.all

    render json: get_json(customers), status: :ok
  end

  def show
    customer = Customer.find_by(id: params[:id])

    if customer
      render json: get_json(customer)
    else
      render_error(:not_found, {customer_id: ["Customer does not exist"] } )
    end
  end


  private

  def get_json(customer_data)
    return customer_data.as_json(except: [:address, :city, :state, :created_at, :updated_at], methods: :movies_checked_out_count)
  end



end
