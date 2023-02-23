class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tours, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :bookings_as_owner, through: :tours, source: :bookings
  validates :first_name, :last_name, presence: true
  has_one_attached :photo
  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end
end
