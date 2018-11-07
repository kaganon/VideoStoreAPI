class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie

  validates :customer_id, :movie_id, presence: true
end
