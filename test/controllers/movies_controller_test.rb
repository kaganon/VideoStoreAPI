require "test_helper"
require "date"
require 'pry'

describe MoviesController do

  MOVIE_FIELDS = %w(id title release_date).sort

  #helper method used to DRY up code
  def check_response(expected_type:, expected_status: :success)
    must_respond_with expected_status
    expect(response.header['Content-Type']).must_include 'json'

    body = JSON.parse(response.body)
    expect(body).must_be_kind_of expected_type
    return body
  end

  describe "index" do
    it "should get index" do
      # Act
      get movies_path

      # Assert
      body = check_response(expected_type: Array)

      expect(body.length).must_equal Movie.count

      #test what is rendered in JSON => returned
      body.each do |movie|
        expect(movie.keys.sort).must_equal MOVIE_FIELDS
      end
    end

    it "returns an empty array when there are no movies" do
      #arrange
      Movie.destroy_all

      #act - invoke controller action by calling path
      get movies_path

      #assert
      body = check_response(expected_type: Array)
      expect(body).must_equal []
    end
  end

  describe 'show' do
    it 'is a real working route and returns JSON for an existing movie' do
      movie = Movie.first

      get movie_path(movie.id)

      body = check_response(expected_type: Hash)

      movie.release_date = movie.release_date.to_s
      movie.save

        MOVIE_FIELDS.each do |key|
          expect(body[key]).must_equal movie[key]
        end

    end


    it 'returns JSON with an error message and status code for a movie that DNE' do
      movie_id = Movie.last.id + 1

      get movie_path(movie_id)

      body = check_response(expected_type: Hash, expected_status: :not_found)

      expect(body["errors"]).must_include "movie_id"
    end
  end

  describe "create" do
    let(:movie_data) {
      {
        title: "test title",
        overview: "test overview",
        release_date: Date.parse("2018-04-12"),
        inventory: 10
      }
    }

    it "creates a new movie given valid data" do

      expect {
        post movies_path, params: movie_data
      }.must_change('Movie.count', +1)


      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
      expect(body).must_include "id"

      movie = Movie.find(body["id"].to_i)

      expect(movie.title).must_equal movie_data[:title]
      must_respond_with :success
    end

    it "returns an error for invalid movie data" do
      # arrange
      movie_data["title"] = nil

      expect {
        post movies_path, params: movie_data
      }.wont_change "Movie.count"

      body = JSON.parse(response.body)

      expect(body).must_be_kind_of Hash
      expect(body).must_include "errors"
      expect(body["errors"]).must_include "title"
      must_respond_with :bad_request
    end
  end

end
