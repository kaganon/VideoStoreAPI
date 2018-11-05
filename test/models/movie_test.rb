require "test_helper"


describe Movie do

  # VALIDATIONS
  describe 'validations' do
    let(:movie) { Movie.create(
      title: 'Rails on Rails on Rails',
      overview: 'Railly railly great movie about rails',
      release_date: Date.parse('2020-11-01'),
      inventory: 2)
    }

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
    let(:movie) { Movie.create(
      title: 'Rails on Rails on Rails',
      overview: 'Railly railly great movie about rails',
      release_date: Date.parse('2020-11-01'),
      inventory: 2)
    }

    let(:customer_1) { Customer.create(
      name: 'Freddy',
      registered_at: Date.parse('1994-07-12'),
      address: '1234 W 5th St',
      city: 'Seattle',
      state: 'Washington',
      postal_code: '90210',
      phone: '111-222-3455'
      )
    }

    it 'must relate to a customer' do
      movie.customers << customer_1

      expect(movie).must_respond_to :customers
      expect(movie.customers.first).must_equal customer_1
    end

  end


end
