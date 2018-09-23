module RatingAverage
  extend ActiveSupport::Concern
  def average_rating
    lkm = ratings.count
    s = ratings
    summa = 0
    s.each do |alkio|
      summa += alkio.score
    end
    summa.to_f / lkm
  end
end
