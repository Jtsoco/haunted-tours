class Review < ApplicationRecord
  belongs_to :user
  belongs_to :tour
  validates :comment, length: {minimum: 5}
  validates :time, presence: true

  def nice_date
    "#{time.day}/#{time.month}/#{time.year} at #{time.strftime('%H')}:#{time.strftime('%M')}"
  end
end
