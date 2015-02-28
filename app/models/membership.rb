class Membership < ActiveRecord::Base
	belongs_to :user
	belongs_to :beer_club
	validates_uniqueness_of :user_id, scope: :beer_club_id
        attr_default :confirmed, false

	scope :unconfirmed, -> (bc) {where confirmed:[nil,false], beer_club_id:bc }
	scope :confirmed, -> (bc) {where confirmed:true, beer_club_id:bc }
	scope :pending, -> (u) {where confirmed:false, user_id:u }
	scope :active, -> (u) {where confirmed:true, user_id:u}

	def to_s
		"#{User.find_by(id:self.user_id).username}, #{BeerClub.find_by(id:self.beer_club_id).name}"
	end
end
