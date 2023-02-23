class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :tour
  enum status: [ :pending, :accepted, :rejected, :canceled]
  scope :booked, -> { where(booked: true) }

  def nice_date
    "#{start_date.day}/#{start_date.month}/#{start_date.year} at #{start_date.strftime('%H')}:#{start_date.strftime('%M')}"
  end

end
