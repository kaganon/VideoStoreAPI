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
    let(:titanic) { movies(:movie_1) }
    let(:finding_nemo) { movies(:movie_2) }

    it 'can set and relate to rentals' do
      blockbuster_1 = Rental.create(customer: jackson, movie: titanic)
      blockbuster_2 = Rental.create(customer: jackson, movie: finding_nemo)

      expect( jackson ).must_respond_to :rentals
      jackson.rentals.each do |rental|
        rental.must_be_kind_of Rental
      end

      expect( jackson.rentals.count ).must_equal 3
      # the newly created rentals + 1 rental in yml file
    end
  end

  # CUSTOM METHODS
  describe 'find_rental' do
    let(:molly) { customers(:customer_1) }
    let(:movie) { movies(:movie_1) }
    let(:matching_rental) { rentals(:rental_1) }

    it 'returns the correct matching rental from the matching movie found' do
      expect( molly.find_rental(movie) ).must_equal matching_rental
    end

    it "returns false if no rental matches movies from customer's rentals" do
      no_movie = nil

      expect( molly.find_rental(no_movie) ).must_equal false
    end
  end

  describe 'movies_checked_out_count' do
    let(:molly_three_out) { customers(:customer_1) }
    let(:mike_none_out) { customers(:customer_3) }

    it "returns the correct movies checked out count" do
      expect( molly_three_out.movies_checked_out_count ).must_equal 3
    end

    it 'returns 0 if there are no movies checked out' do
      expect( mike_none_out.movies_checked_out_count ).must_equal 0
    end
  end

end
