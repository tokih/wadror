class User < ActiveRecord::Base
	has_many :ratings, dependent: :destroy
	has_many :beers, through: :ratings
	has_many :memberships, dependent: :destroy
	has_many :beer_clubs, through: :memberships
	validates :username, uniqueness: true, length: { minimum: 3, maximum: 15 }
	validates :password, length: { minimum: 4 }, :format => {:with => /\A(?=.*[a-zA-Z])(?=.*[0-9]).{4,}\z/}
	include RatingAverage
	has_secure_password
	
	def to_s
		"#{self.username}"
	end

	def favorite_beer
		return nil if ratings.empty?
		ratings.order(score: :desc).limit(1).first.beer
	end

        def favorite_style
		return nil if ratings.empty?
		avgs = Hash.new []
		ratings.each do |r|
			avgs[r.beer.style] << r.score
		end
		avgs
		#avgs.sort_by { |style, avg| avg.inject{ |sum, el| sum + el }.to_f / avg.size }
	end

end
