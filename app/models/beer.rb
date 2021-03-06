class Beer < ApplicationRecord
  include RatingAverage
  belongs_to :brewery, touch: true
  belongs_to :style
  has_many :ratings, dependent: :destroy
  has_many :raters, -> { distinct }, through: :ratings, source: :user
  validates :name, presence: true
  validates :style_id, presence: true

  def to_s
    n = brewery_id
    m = Brewery.find_by(id: n)
    "#{name}, #{m.name}"
  end

  def self.top(n)
    beers = Beer.all.sort_by{ |b| -(b.average_rating || 0) }
    beers.take(n)
  end

  def average
    if ratings.count.zero?

      return 0

    end

    ratings.map{ :score }.sum / ratings.count.to_f
  end
end
