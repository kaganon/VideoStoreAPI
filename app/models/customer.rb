class Customer < ApplicationRecord
  validates :name, :registered_at, :address, :city, :state, :postal_code, :phone,  presence: true
  has_many :rentals, dependent: :destroy

  def find_rental(movie)
    self.rentals.each do |rental|
      return rental if rental.movie == movie
    end
  end

  def movies_checked_out_count
    return self.rentals.where(checkin_date: nil).count
  end
end
