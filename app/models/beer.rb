class Beer < ApplicationRecord
  include RatingAverage
  belongs_to :brewery
  has_many :ratings, dependent: :destroy
  has_many :raters, -> { distinct }, through: :ratings, source: :user
  validates :name, presence: true
  def to_s
    n = brewery_id
    m = Brewery.find_by(id: n)
    "#{name}, #{m.name}"
  end

  def average
    if ratings.count.zero?

      return 0

    end

    ratings.map{ :score }.sum / ratings.count.to_f
  end
end
