class Brewery < ApplicationRecord
  include RatingAverage
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers
  validates :name, presence: true
  validates :year, numericality: { greater_than: 1039 }
  validate :smaller_than_this_year
  scope :active, -> { where active: true }
  scope :retired, -> { where active: [nil, false] }

  def smaller_than_this_year
    if year > Date.today.year
      errors.add(:year, "can't be in the future")
    end
  end

  def self.top(n)
    brews = Brewery.all.sort_by{ |b| -(b.average_rating || 0) }
    brews.take(n)
  end

  def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beers #{beers.count}"
  end

  def restart
    self.year = 2018
    puts "changed year to #{year}"
  end

  def to_s
    name.to_s
  end
end
