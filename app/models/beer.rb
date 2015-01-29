class Beer < ActiveRecord::Base
	include RatingAverage

	belongs_to :brewery
	has_many :ratings, dependent: :destroy

	def to_s
		"#{Brewery.find_by(id:self.brewery.id).name}  #{self.name}"
	end
end
