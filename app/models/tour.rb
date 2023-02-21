class Tour < ApplicationRecord
  belongs_to :user
  has_many :bookings
  validates :name, :description, :location, :price, presence: true
end
