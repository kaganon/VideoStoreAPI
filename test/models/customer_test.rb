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
  describe 'relations' do
    let(:jackson) { customers(:customer_2) }
    let(:rental) { rentals(:rental_2) }

    it 'can set a rental' do
      titanic = Movie.first
      blockbuster = Rental.create(customer: jackson, movie: titanic)

      expect( blockbuster.valid? ).must_equal true
      expect( blockbuster.customer ).must_equal jackson
      expect( blockbuster.customer ).must_be_kind_of Customer

    end
  end

  # CUSTOM METHODS
  describe 'find_rental' do
    let(:molly) { customers(:customer_1) }
    let(:movie) { movies(:movie_1) }
    let(:rental) { rentals(:rental_1) }

    it 'returns a rental if belongs to customer' do
      expect( molly.find_rental(movie) ).must_equal rental
    end
  end

  describe 'movies_checked_out_count' do
    let(:molly) { customers(:customer_1) }
    let(:movie) { movies(:movie_1) }
    let(:rental) { rentals(:rental_1) }

    it "returns zero if checkout.count or checkin.count == zero" do

      molly.rentals.destroy_all

      expect( molly.movies_checked_out_count ).must_equal 0
      expect( molly.rentals.count ).must_equal 0
    end
  end

end
