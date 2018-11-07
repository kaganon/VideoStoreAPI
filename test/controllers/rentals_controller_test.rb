require "test_helper"
require "pry"

describe RentalsController do

  RENTAL_FIELDS = %w(checkin_date checkout_date created_at customer_id due_date id movie_id updated_at).sort

  def check_response(expected_type:, expected_status: :success)
    must_respond_with expected_status
    expect(response.header['Content-Type']).must_include 'json'

    body = JSON.parse(response.body)
    expect(body).must_be_kind_of expected_type
    return body
  end

  describe "index" do
    it "is a real working route" do
      get rentals_path

      body = check_response(expected_type: Array)

      expect(body.length).must_equal Rental.count

      body.each do |rental|
        expect(rental.keys.sort).must_equal RENTAL_FIELDS
      end
    end

    it "returns an empty array when there are no customers" do
      Rental.destroy_all

      get rentals_path

      body = check_response(expected_type: Array)

      expect(body).must_equal []
    end
  end

  describe 'checkout' do
    it "creates a new rental with valid data" do
      rental_data =
      {
        customer_id: Customer.first.id,
        movie_id: Movie.first.id
      }

      expect {
        post checkout_path, params: rental_data
      }.must_change('Rental.count', +1)
      
      #assert
      # It creates a new instance of Rental
      # it doesn't not create new instance if customer = bogus data
      # it does not create new instance if movie = bogus data
      # it does not create a new instance if movie.available_inventory < 1 && includes error message line:30
      # it can create with valid data
      # changes customer.movie.count
      # changes movie.available_inventory.count
      # it sets checkout date
      # it sets due date
      # it renders json
      # it renders error for all, :not_found if invalid
    end
  end

  describe 'checkin' do
    # it finds a customer based on params
    # it finds a movie based on params
    # its sets date
    # it finds assigns rental from customer movies
    # it assigns checkin date
    # it changes checkout date
    # it changes movie.available_inventory.count
    # it changes customer.movie.count
    # it renders json
    # it renders errors, :not_found if invalid
  end

end
