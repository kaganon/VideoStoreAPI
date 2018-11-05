require "test_helper"

describe Customer do
  # VALIDATIONS
  describe 'validations' do
    let(:customer) { Customer.create(
      name: "Mickey"
      registered_at: Date.parse('2020-11-01'),
      address: '1234 W. 5th Street',
      city: "Avondale",
      state: "Arizona",
      postal_code: "90210",
      phone: "555-867-5309"
    )
    }

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
  describe 'Relations' do
    let(:customer) { Customer.create(
      name: "Mickey"
      registered_at: Date.parse('2020-11-01'),
      address: '1234 W. 5th Street',
      city: "Avondale",
      state: "Arizona",
      postal_code: "90210",
      phone: "555-867-5309"
    )
    }

    let(:movie_1) { Movie.create(
      title: 'Five Nights at Freddys',
      release_date: Date.parse('1994-07-12'),
      overview: 'Scariness on film reel',
      inventory: 5
      )
    }

    it 'must relate to a customer' do
      customer.movies << movie_1

      expect(customer).must_respond_to :movies
      expect(customer.movies.first).must_equal movie_1
    end

    # it 'can set the customers' do
    # end

  end
end
