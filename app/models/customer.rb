class Customer < ApplicationRecord
  validates :name, :registered_at, :address, :city, :state, :postal_code, :phone, :movies_checked_out_count, presence: true
  has_many :rentals

  def find_rental(movie)

    self.rentals.each do |rental|
      return rental if rental.movie == movie
    end

  end

  def movies_checked_out_count
    return self.rentals.all.where.not(checkout_date: nil).count
  end


end
