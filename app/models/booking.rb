class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :tour

  def pending?
    status == 'pending'
  end
  scope :booked, -> { where(booked: true) }

end
