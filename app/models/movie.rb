class Movie < ApplicationRecord
  validates :title, :overview, :release_date, :inventory, presence: true
  has_many :rentals

  def available_inventory
    checked_out = self.rentals.where.not(checkout_date: nil).count
    return self.inventory - checked_out
  end

end
