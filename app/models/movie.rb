class Movie < ApplicationRecord
  validates :title, :overview, :release_date, :inventory, presence: true
  has_many :rentals, dependent: :destroy
end
