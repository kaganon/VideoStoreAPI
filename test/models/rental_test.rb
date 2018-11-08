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

  describe 'is_available?' do
    let(:rental) { rentals(:rental_1) }

    it 'returns false if rental.avalable_inventory is equal to zero' do
      movie = rental.movie
      movie.inventory = 0

      expect( rental.is_available? ).must_equal false
    end

    it 'returns false if rental.available_inventory is less than 0' do
      movie = rental.movie
      movie.inventory = -1


      expect( rental.is_available? ).must_equal false
    end

    it 'returns true if rental.available_inventory is greater than 0' do
      expect( rental.is_available? ).must_equal true
    end

    # it 'returns as not true if rental is invalid/DNE' do
    #   rental.movie = nil
    #   rental.customer = nil
    #
    #   result = rental.valid?
    #
    #   expect( result ).wont_equal true
    # end
  end

  DATE = Date.today

  describe 'update_check_out_date' do
    let(:movie) { movies(:movie_3) }
    let(:jackson) { customers(:customer_1) }

    it 'returns current date when rental is valid' do
      new_rental = Rental.create(customer: jackson, movie: movie)

      expect( new_rental.update_check_out_date ).must_equal DATE
    end
  end

  describe 'update_due_date' do
    let(:movie) { movies(:movie_3) }
    let(:jackson) { customers(:customer_1) }

    it 'returns due date when rental is valid' do
      new_rental = Rental.create(customer: jackson, movie: movie)

      expect( new_rental.update_due_date ).must_equal (DATE + 7)
    end
  end

  describe 'update_checkin_date' do
    let(:rental) { rentals(:rental_2) }

    it 'returns due date when rental is valid' do
      rental.checkin_date = Date.today

      expect( rental.update_checkin_date ).must_equal DATE
    end
  end

end
