class Brewery < ActiveRecord::Base
	include RatingAverage
	validates :name, presence: true
	validates :year, numericality: { greater_than_or_equal_to: 1042, only_integer: true }
	validate :validates_year

	has_many :beers, dependent: :destroy
	has_many :ratings, through: :beers

	def print_report
		puts name
		puts "established at year #{year}"
		puts "number of beers #{beers.count}"
	end

	def restart
		self.year = 2015
		puts "changed year to #{year}"
	end

	def to_s
		self.name
	end

	def validates_year
		if self.year.present? && self.year > Date.today.year
			errors.add(:year, "year cannot be in the future")
		end
	end
end
