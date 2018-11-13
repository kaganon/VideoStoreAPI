class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie

  validates :customer_id, :movie_id, presence: true
  validates :checkout_date, :due_date, presence: true, on: :checkout
  validates :checkin_date, presence: true, on: :checkin

  DATE = Date.today

  def is_available?
    return self.movie.available_inventory > 0 if self.movie
    return false
  end

  def update_check_out_date
    return self.checkout_date = DATE
  end

  def update_due_date
    return self.due_date = (DATE + 7)
  end

  def update_checkin_date
    return self.checkin_date = DATE
  end
end
