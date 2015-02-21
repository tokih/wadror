class Style < ActiveRecord::Base
  has_many :beers

  def self.top(n)
    sorted_by_rating_in_desc_order = Style.all.sort_by{ |s| -(s.average_rating||0) }
    sorted_by_rating_in_desc_order.take(n)
  end

  def average_rating
    return 0 if beers.empty?
    arr = []
    beers.each do |beer|
      if not beer.ratings.empty?
        beer.ratings.each do |rating|
          arr << rating.score
        end
      else
        arr << 0
      end
    end
    arr.inject{ |sum, el| sum + el }.to_f / arr.size
  end
end
