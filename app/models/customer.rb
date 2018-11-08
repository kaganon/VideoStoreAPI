class Customer < ApplicationRecord
  validates :name, :registered_at, :address, :city, :state, :postal_code, :phone,  presence: true
  has_many :rentals, dependent: :destroy

  def find_rental(movie)
    if self.rentals
      self.rentals.each do |rental|
        return rental if rental.movie == movie
      else return ArgumentError
      end
    end

  end

  def movies_checked_out_count
    return self.rentals.where(checkin_date: nil).count
  end
end
