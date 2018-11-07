require "test_helper"

describe CustomersController do

  CUSTOMER_FIELDS = %w(id name movies_checked_out_count registered_at postal_code phone).sort

  def parse_json(expected_type:, expected_status: :success)
    must_respond_with expected_status

    expect(response.header['Content-Type']).must_include 'json'

    body = JSON.parse(response.body)
    expect(body).must_be_kind_of expected_type
    return body
  end

  describe "index" do
    it "is a real working route" do
      get customers_path

      body = parse_json(expected_type: Array)

      expect(body.length).must_equal Customer.count

      body.each do |customer|
        expect(customer.keys.sort).must_equal CUSTOMER_FIELDS
      end
    end

    it "returns an empty array when there are no customers" do
      Customer.destroy_all

      get customers_path

      body = parse_json(expected_type: Array)

      expect(body).must_equal []
    end
  end


  describe 'show' do

    it 'is a real working route and returns JSON for an existing customer' do
      customer = Customer.first

      get customer_path(customer.id)

      body = parse_json(expected_type: Hash)

      CUSTOMER_FIELDS.each do |key|
        expect(body[key]).must_equal customer[key]
      end


    end


    it 'returns JSON with an error message and status code for a customer that DNE' do
      customer_id = Customer.last.id + 1

      get customer_path(customer_id)

      body = parse_json(expected_type: Hash, expected_status: :not_found)

      expect(body["errors"]).must_include "customer_id"
    end
  end

end
