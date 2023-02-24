class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :tour

  validates :guests, numericality: { greater_than: 0 }

  def pending?
    status == 'pending'
  end

  def nice_date
    "#{start_date.day}/#{start_date.month}/#{start_date.year} at #{start_date.strftime('%H')}:#{start_date.strftime('%M')}"
  end

  enum status: [ :pending, :accepted, :rejected, :canceled]
  # scope :booked, -> { where(booked: true) }
  scope :pending, -> { where(status: :pending) }
  scope :accepted, -> { where(status: :accepted) }
  scope :rejected, -> { where(status: :rejected) }
  scope :canceled, -> { where(status: :canceled) }
end
