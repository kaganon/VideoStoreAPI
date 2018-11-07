class Movie < ApplicationRecord
  validates :title, :overview, :release_date, :inventory, presence: true
  has_many :customers
end
