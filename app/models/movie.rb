class Movie < ApplicationRecord
  validates :title, :overview, :release_date, :inventory, presence: true
  has_and_belongs_to_many :customers
end
