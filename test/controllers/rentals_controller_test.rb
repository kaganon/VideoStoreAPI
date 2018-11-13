require "test_helper"
require "pry"

describe RentalsController do

  RENTAL_FIELDS = %w(id customer_id movie_id checkout_date due_date checkin_date).sort

  def parse_json(expected_type:, expected_status: :success)
    must_respond_with expected_status
    expect(response.header['Content-Type']).must_include 'json'

    body = JSON.parse(response.body)
    expect(body).must_be_kind_of expected_type
    return body
  end

  describe 'checkout' do
    let(:mimi) { customers(:customer_4) }
    let(:jaws) { movies(:movie_2) }

    let(:rental_params) {
      { customer_id: mimi.id,
        movie_id: jaws.id
      }
    }
    it "creates a new rental and returns JSON with an id when give valid input" do

      expect {
        post checkout_path, params: rental_params
      }.must_change('Rental.count', +1)

      body = parse_json(expected_type: Hash)

      expect(body.keys).must_include "rental_id"

      rental = Rental.last
      expect(rental.customer_id).must_equal rental_params[:customer_id]
      expect(rental.movie_id).must_equal rental_params[:movie_id]
      expect(rental.checkout_date).must_equal Date.today
      expect(rental.due_date).must_equal (Date.today + 7)

    end

    it "renders bad_request status code and returns JSON with error messages if the rental was not successfully saved" do

      # QUESTION: not sure how to setup the controller test and make saving the rental fail. Checkout date and due date is not a required validation until trying to save upon checkout. The rental.save method would fail if checkout_date and due_date somehow returns nil or false upon checkout, and therefore return the error messages...but this is difficult to test in the controller tests using the post checkout_path bc valid params would always save the rental.
    end

    it 'renders not_found and does not save rental if no rental information matches params' do

      original_last_rental = Rental.last
      rental_params[:movie_id] = nil

      expect {
        post checkout_path, params: rental_params
      }.wont_change('Rental.count')

      rental = Rental.last
      body = parse_json(expected_type: Hash, expected_status: :not_found)
      expect(rental).must_equal original_last_rental
      expect(body.keys).must_include "errors"
      expect(body.values.first["rental_id"]).must_equal ["Cannot checkout movie: no available inventory for checkout"]

    end
  end

  describe 'checkin' do

    let(:rental) { rentals(:rental_3) }

    let(:rental_params) {
      { customer_id: rental.customer.id, # id: 1
        movie_id: rental.movie.id  # id: 2
      }
    }

    it 'checks-in the correct rental with valid input params and updates the checkin date to today' do

      to_check_in_rental = Rental.find_by(customer_id: 1, movie_id: 2)

      to_check_in_rental.checkin_date.must_be_nil

      post checkin_path, params: rental_params

      body = parse_json(expected_type: Hash)

      checked_in_rental = Rental.find_by(customer_id: 1, movie_id: 2)

      expect(body.keys).must_include "rental_id"
      expect(checked_in_rental.checkin_date).must_equal Date.today

    end

    it "renders bad_request status code and returns JSON with error messages if the rental was not successfully saved" do
      # same question as above
    end

    it "renders not found status code and returns JSON with error message if no movie matches movie params" do

      expect(rental.checkin_date).must_be_nil
      rental_params[:movie_id] = 0

      post checkin_path, params: rental_params

      body = parse_json(expected_type: Hash, expected_status: :not_found)
      expect(rental.checkin_date).must_be_nil
      expect(body.keys).must_include "errors"
      expect(body.values.first["rental_id"]).must_equal ["No matching rental found for this customer and movie"]

    end

    it 'renders not found status code and returns JSON with error message if no customer matches customer params' do
      expect(rental.checkin_date).must_be_nil

      rental_params[:customer_id] = nil

      post checkin_path, params: rental_params

      body = parse_json(expected_type: Hash, expected_status: :not_found)
      expect(rental.checkin_date).must_be_nil
      expect(body.keys).must_include "errors"
      expect(body.values.first["rental_id"]).must_equal ["No matching rental found for this customer and movie"]
    end

  end



end
