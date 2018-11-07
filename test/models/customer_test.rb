require "test_helper"

describe Customer do
  # VALIDATIONS
  describe 'validations' do
    let(:customer) { customers(:customer_1) }

    it 'is invalid without a name' do
      customer.name = nil

      customer.name.must_be_nil
      expect(customer).must_be :invalid?
    end

    it 'is invalid without a registration date' do
      customer.registered_at = nil

      customer.registered_at.must_be_nil
      expect(customer).must_be :invalid?
    end

    it 'is invalid without an address' do
      customer.address = nil

      customer.address.must_be_nil
      expect(customer).must_be :invalid?
    end

    it 'is invalid without a city' do
      customer.city = nil

      customer.city.must_be_nil
      expect(customer).must_be :invalid?
    end

    it 'is invalid without a state' do
      customer.state = nil

      customer.state.must_be_nil
      expect(customer).must_be :invalid?
    end

    it 'is invalid without a postal_code' do
      customer.postal_code = nil

      customer.postal_code.must_be_nil
      expect(customer).must_be :invalid?
    end

    it 'is invalid without a phone number' do
      customer.phone = nil

      customer.phone.must_be_nil
      expect(customer).must_be :invalid?
    end

    it 'is valid with all fields present' do
      expect(customer).must_be :valid?
    end


  end


  # RELATIONS

end
