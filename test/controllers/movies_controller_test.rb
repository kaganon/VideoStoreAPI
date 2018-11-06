require "test_helper"
require 'pry'

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
    it "can create a movie with valid data" do
      movie_data = {
        movie: {
          title: "test title",
          overview: "test overview",
          release_date: Date.parse("2018-04-12"),
          inventory: 10
        }
      }

      # Assumptions
      Movie.create(movie_data[:movie]).must_be :valid?, "Movie data wasn't invalid. Please come fix this test"

      # Act
      expect {
        post movies_path, params: movie_data
      }.must_change('Movie.count', +1)
      # Assert
      must_respond_with :success
    end

    it "does not create a new movie w/ invalid data" do
      movie_data = {
        movie: {
          title: "",
          overview: "test overview",
          release_date: Date.parse("2018-04-12"),
          inventory: 10
        }
      }

      # Assumptions
      film = Movie.create(movie_data[:movie]).wont_be :valid?, "Movie data wasn't invalid. Please come fix this test"

      # Act
      expect {
        post movies_path, params: movie_data
      }.wont_change('Movie.count')

      # Assert
      must_respond_with :bad_request

    end
  end


end
