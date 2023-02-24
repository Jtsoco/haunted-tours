class Tour < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  validates :name, :description, :location, :price, presence: true
  validates :price, numericality: { greater_than: 0 }
  has_many_attached :photos
end
