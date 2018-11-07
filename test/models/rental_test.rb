require "test_helper"

describe Rental do

  describe 'validations' do
    let(:rental) { rentals(:rental_1) }

    it 'is invalid without customer_id' do
      rental.customer_id = nil

      rental.customer.must_be_nil
      expect(rental.valid?).wont_equal true
    end

    it 'is invalid without movie_id' do
      rental.movie_id = nil

      rental.movie.must_be_nil
      expect(rental.valid?).wont_equal true
    end
  end

  describe 'relations' do
    let(:rental) { rentals(:rental_2) }

    it 'can set a customer and movie' do
      leo = Customer.first
      titanic = Movie.first
      rental = Rental.create(customer: leo, movie: titanic)

      expect( rental.valid? ).must_equal true
      expect( rental.customer ).must_equal leo
      expect( rental.movie ).must_equal titanic
    end

    it "must relate to a movie" do
      expect( rental ).must_respond_to :movie
      expect( rental.movie ).must_equal movies(:movie_1)
    end

    it "must relate to a customer" do
      expect( rental ).must_respond_to :customer
      expect( rental.customer ).must_equal customers(:customer_2)
    end
  end

end
