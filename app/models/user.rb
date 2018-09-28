class User < ApplicationRecord
  include RatingAverage
  validates :username, uniqueness: true
  validates :username, length: { minimum: 3 }
  validates :username, length: { maximum: 30 }
  validates :password, format: { with: /\A^(?=.*[a-zA-Z])(?=.*[0-9]).{4,}\z/, message: "must be atleast 4 characters long and contain a number and big letter." }
  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships
  has_many :beer_clubs, through: :memberships
  has_secure_password
end

class Rating < ApplicationRecord
  belongs_to :beer
  belongs_to :user

  def to_s
    "#{beer.name} #{score}"
  end
end
