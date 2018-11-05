class Movie < ApplicationRecord
  validates :title, :overview, :release_date, :inventory, presence: true
end
