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

  def create
    customer = Customer.new(customer_params)

    if customer.save
      render json: { id: customer.id }
    else
      render_error(:bad_request, customer.errors.messages)
    end
  end


  private

  def customer_params
    params.require(:customer).permit(:name, :registered_at, :address, :city, :state, :postal_code, :phone)
  end

  def get_json(customer_data)
    return customer_data.as_json(except: [:address, :city, :state, :created_at, :updated_at])
  end



end
