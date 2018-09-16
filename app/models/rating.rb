class Rating < ApplicationRecord
    belongs_to :beer
    def to_s
      a = Beer.find_by(id: self.beer_id)
      "#{a.name} #{self.score}"
    end
end
