require "test_helper"

describe Rental do

  # VALIDATIONS
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

    it 'is valid with customer and movie ids present' do
      expect(rental).must_be :valid?
    end
  end

  # RELATIONS
  describe 'relations' do
    let(:movie) { movies(:movie_2) }
    let(:customer) { customers(:customer_3) }
    let(:rental) { rentals(:rental_2)}

    it 'can set a customer and movie' do
      leo = customer
      titanic = movie
      new_rental = Rental.create(customer: leo, movie: titanic)

      expect( new_rental.valid? ).must_equal true
      expect( new_rental.customer ).must_equal leo
      expect( new_rental.movie ).must_equal titanic
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

  # CUSTOM METHODS
  describe 'is_available?' do
    let(:linda) { customers(:customer_4) }
    let(:all_checked_out) { movies(:movie_3) }
    let(:available_for_check_out) { movies(:movie_2) }
    let(:rental_data) {
      {
        customer_id: linda.id,
        movie_id: all_checked_out.id,
      }
    }

    it 'returns false if the movie for rental is not available' do
      new_rental = Rental.create(rental_data)

      expect( new_rental.is_available? ).must_equal false
    end

    it 'returns true if the movie for rental is available' do
      rental_data[:movie_id] = available_for_check_out.id
      new_rental = Rental.create(rental_data)

      expect( new_rental.is_available? ).must_equal true
    end

    it 'returns false if the rental movie is nil' do
      rental_data[:movie_id] = nil
      new_rental = Rental.create(rental_data)

      expect( new_rental.is_available? ).must_equal false
    end
  end

  DATE = Date.today

  describe 'update_check_out_date' do
    let(:movie) { movies(:movie_3) }
    let(:jackson) { customers(:customer_1) }

    it "updates checkout date to today's date" do
      new_rental = Rental.create(customer: jackson, movie: movie)

      expect( new_rental.update_check_out_date ).must_equal DATE
    end
  end

  describe 'update_due_date' do
    let(:movie) { movies(:movie_3) }
    let(:jackson) { customers(:customer_1) }

    it "updates the due date to 7 days from today's date" do
      new_rental = Rental.create(customer: jackson, movie: movie)

      expect( new_rental.update_due_date ).must_equal (DATE + 7)
    end
  end

  describe 'update_checkin_date' do
    let(:movie) { movies(:movie_3) }
    let(:jackson) { customers(:customer_1) }

    it "updates checkin date to today's date" do
      rental = Rental.create(customer: jackson, movie: movie)

      expect( rental.update_checkin_date ).must_equal DATE
    end
  end

end
