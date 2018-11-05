class Customer < ApplicationRecord
  validates :name, :registered_at, :address, :city, :state, :postal_code, :phone, presence: true
  has_and_belongs_to_many :movies
end
