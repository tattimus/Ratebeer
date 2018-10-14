module RatingAverage
  extend ActiveSupport::Concern
  def average_rating
    lkm = ratings.count
    s = ratings
    summa = 0
    s.each do |alkio|
      summa += alkio.score
    end
    if summa.zero?
      return 0.0
    else
      summa.to_f / lkm
    end
  end
end
