class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie

  validates :customer_id, :movie_id, presence: true

  def movie_inventory(movie)
    movie = self.movie.find_by(movie_id: movie.id)
    return movie.inventory -= 1
  end
end
