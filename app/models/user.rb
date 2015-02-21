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
		style_ratings = rated_styles.inject([]) { |set, style| set << [style, style_average(style)] }
		style_ratings.sort_by { |r| r.last }.last.first
	end

	def favorite_brewery
		return nil if ratings.empty?
		brewery_ratings = rated_breweries.inject([]) { |set, brewery| set << [brewery, brewery_average(brewery)] }
		brewery_ratings.sort_by { |r| r.last }.last.first
	end

	#private

	def rated_styles
		ratings.map { |r| r.beer.style }.uniq
	end
	
	def style_average(style)
		ratings_of_style = ratings.select { |r| r.beer.style == style }
		ratings_of_style.inject(0.0) { |sum, r| sum+r.score}/ratings_of_style.count
	end

	def rated_breweries
		ratings.map { |r| r.beer.brewery}.uniq
	end

	def brewery_average(brewery)
		ratings_of_brewery = ratings.select { |r| r.beer.brewery == brewery }
		ratings_of_brewery.inject(0.0) { |sum, r| sum+r.score}/ratings_of_brewery.count
	end

	def self.top_raters(n)
		sorted_by_ratings_count_in_desc_order = User.all.sort_by{ |u| -(u.ratings.count||0) }
		sorted_by_ratings_count_in_desc_order.take(n)
	end

	def account_status
		if self.locked
			return 'account locked'
		else
			return 'account enabled'
		end
	end

end
