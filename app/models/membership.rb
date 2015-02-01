class Membership < ActiveRecord::Base
	belongs_to :user
	belongs_to :beer_club
	validates_uniqueness_of :user_id, scope: :beer_club_id

	def to_s
		"#{User.find_by(id:self.user_id).username}, #{BeerClub.find_by(id:self.beer_club_id).name}"
	end
end
