require "test_helper"

describe Movie do

  # VALIDATIONS
  describe 'validations' do
    let(:movie) { movies(:movie_1) }

    it 'is invalid without a title' do
      movie.title = nil

      movie.title.must_be_nil
      expect(movie).must_be :invalid?
    end

    it 'is invalid without an overview' do
      movie.overview = nil

      movie.overview.must_be_nil
      expect(movie).must_be :invalid?
    end

    it 'is invalid without a release date' do
      movie.release_date = nil

      movie.release_date.must_be_nil
      expect(movie).must_be :invalid?
    end

    it 'is invalid without an inventory' do
      movie.inventory = nil

      movie.inventory.must_be_nil
      expect(movie).must_be :invalid?
    end

    it 'is valid with all fields present' do
      expect(movie).must_be :valid?
    end
  end


  # RELATIONS
  describe 'relations' do
    let(:titanic) { movies(:movie_2) }
    let(:jackson) { customers(:customer_2) }
    let(:avery) { customers(:customer_4) }

    it 'can set and relate to rentals' do
      blockbuster_1 = Rental.create(customer: jackson, movie: titanic)
      blockbuster_2 = Rental.create(customer: avery, movie: titanic)

      expect( titanic ).must_respond_to :rentals
      titanic.rentals.each do |rental|
        rental.must_be_kind_of Rental
      end
    end

  end

  # CUSTOM METHODS
  describe 'available_inventory' do
    let(:customer) { customers(:customer_1) }
    let(:two_available_movies) { movies(:movie_2) }
    let(:no_available_movie) { movies(:movie_3) }

    it 'returns the correct available inventory for available movies' do
      expect( two_available_movies.available_inventory ).must_equal 2
    end

    it 'returns 0 if all movies checked out' do
      expect( no_available_movie.available_inventory ).must_equal 0
    end

  end


end
