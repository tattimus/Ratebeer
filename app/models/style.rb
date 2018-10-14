class Style < ApplicationRecord
  has_many :beers

  def self.top(n)
    style = Style.all.sort_by{ |s| -(s.rating_average) }
    style.take(n)
  end

  def rating_average
    summa = beers.sum{ |b| b.average_rating }
    lkm = beers.count{ |b| b.ratings.count > 0 }
    if summa.zero?
      return 0.0
    else
      summa / lkm
    end
  end
end
