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

  def favorite_beer
    return nil if ratings.empty?

    ratings.order(score: :desc).limit(1).first.beer
  end

  def average_of(ratings)
    ratings.sum(&:score).to_f / ratings.count
  end

  def favorite_style
    return nil if ratings.empty?

    style_ratings = ratings.group_by{ |r| r.beer.style }
    averages = style_ratings.map do |style, ratings|
      { style: style, score: average_of(ratings) }
    end

    averages.max_by{ |r| r[:score] }[:style]
  end

  def favorite_brewery
    return nil if ratings.empty?

    style_ratings = ratings.group_by{ |r| r.beer.brewery }
    averages = style_ratings.map do |brewery, ratings|
      { brewery: brewery, score: average_of(ratings) }
    end

    averages.max_by{ |r| r[:score] }[:brewery]
  end
end
