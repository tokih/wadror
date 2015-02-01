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
end
