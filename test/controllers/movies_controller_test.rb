require "test_helper"

describe MoviesController do
  # it "must be a real test" do
  #   flunk "Need real tests"
  # end
  describe "index" do
    it "should get index" do
      # Act
      get movies_path

      # Assert
      must_respond_with :success
    end
  end

  describe "create" do
    let(:movie) { Movie.create(
      title: 'Rails on Rails on Rails',
      overview: 'Railly railly great movie about rails',
      release_date: Date.parse('2020-11-01'),
      inventory: 2)
    }

    it "can create a movie with valid data" do
      # Arrange

      # Assumptions
      test_movie = Movie.new(movie_data[:movie])
      test_movie.must_be :valid?, "Movie data was invalid. Please come fix this test"

      # Act
      expect {
        post movies_path, params: movie_data
      }.must_change('Movie.count', +1)

      # Assert
      must_redirect_to movie_path(Movie.last)
    end

    it "does not create a new movie w/ invalid data" do
      # Arrange
      movie_data = {
        movie: {
          title: Movie.first.title,
          author_id: Author.first.id
        }
      }

      # Assumptions
      Movie.new(movie_data[:movie]).wont_be :valid?, "Movie data wasn't invalid. Please come fix this test"

      # Act
      expect {
        post movies_path, params: movie_data
      }.wont_change('Movie.count')

      # Assert
      must_respond_with :bad_request
    end
  end


end
