class Beer < ApplicationRecord
  include RatingAverage
  belongs_to :brewery
  has_many :ratings, dependent: :destroy
  def to_s
    n = self.brewery_id
    m = Brewery.find_by(id: n)
    "#{self.name}, #{m.name}"
  end
end