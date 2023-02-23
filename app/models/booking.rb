class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :tour
  scope :booked, -> { where(booked: true) }
end
