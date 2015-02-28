class Beer < ActiveRecord::Base
	include RatingAverage
	validates :name, presence: true
	belongs_to :brewery, touch:true
	has_many :ratings, dependent: :destroy
	has_many :raters, through: :ratings, source: :user
        belongs_to :style

	def self.top(n)
		sorted_by_rating_in_desc_order = Beer.all.sort_by{ |b| -(b.average_rating||0) }
		sorted_by_rating_in_desc_order.take(n)
	end


	def to_s
		"#{Brewery.find_by(id:self.brewery.id).name}  #{self.name}"
	end
end
