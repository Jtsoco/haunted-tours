class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :tour

  def pending?
    status == 'pending'
  end
  scope :pending, -> { where(status: :pending) }
  scope :accepted, -> { where(status: :accepted) }
  scope :rejected, -> { where(status: :rejected) }
  scope :canceled, -> { where(status: :canceled) }
end
