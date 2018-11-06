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
  describe 'Relations' do
    let(:movie) { movies(:movie_1) }

    let(:becky) { customers(:customer_1) }

    it 'must relate to a customer' do
      movie.customers << becky

      expect(movie).must_respond_to :customers
      expect(movie.customers.first).must_equal becky
    end

  end


end
