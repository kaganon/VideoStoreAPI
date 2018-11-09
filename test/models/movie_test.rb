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

    it 'can set a rental' do
      jackson = Customer.first
      blockbuster = Rental.create(customer: jackson, movie: titanic)

      expect( blockbuster.valid? ).must_equal true
      expect( blockbuster.movie ).must_equal titanic
      expect( blockbuster.movie ).must_be_kind_of Movie
    end
  end

  # HELPER METHODS
  describe 'available_inventory' do
    let(:titanic) { movies(:movie_1) }

    it 'returns number of movies checked out' do
      expect( titanic.available_inventory ).must_equal 2
    end

    # it 'returns ArgumentError if checked_out equals -4' do
    # end
    # it 'returns self.inventory if checked_out equals 0' do
    # end
  end


end
