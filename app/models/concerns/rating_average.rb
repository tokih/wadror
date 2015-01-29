module RatingAverage
	extend ActiveSupport::Concern
        def average_rating
                arr = []
                ratings.each do |rating|
                        arr << rating.score
                end
                arr.inject{ |sum, el| sum + el }.to_f / arr.size
        end
end

