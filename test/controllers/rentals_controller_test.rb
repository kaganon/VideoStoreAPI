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

  # delete this
  describe "index" do
    it "is a real working route" do
      get rentals_path

      body = parse_json(expected_type: Array)

      expect(body.length).must_equal Rental.count

      body.each do |rental|
        expect(rental.keys.sort).must_equal RENTAL_FIELDS
      end
    end

    it "returns an empty array when there are no customers" do
      Rental.destroy_all

      get rentals_path

      body = parse_json(expected_type: Array)

      expect(body).must_equal []
    end
  end


  describe 'checkout' do
    let(:rental_params) {
      { customer_id: Customer.first.id,
        movie_id: Movie.first.id
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

      original_last_rental = Rental.last
      rental_params[:customer_id] = 0

      expect {
        post checkout_path, params: rental_params
      }.wont_change('Rental.count')

      rental = Rental.last
      body = parse_json(expected_type: Hash, expected_status: :bad_request)
      expect(rental).must_equal original_last_rental
      expect(body.keys).must_include "errors"

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

    end
  end

  describe 'checkin' do
    it 'updates the correct rental that matches valid input params' do
      
    end





  end


end
