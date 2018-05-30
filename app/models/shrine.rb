class Shrine < ApplicationRecord
  belongs_to :user
  has_many :offerings

  has_many :active_offerings,   -> { active },   class_name: "Offering"
  has_many :inactive_offerings, -> { inactive }, class_name: "Offering"

  has_many :inactive_items, through: :inactive_offerings,
                             class_name: "Item",
                             source: :item
  has_many :active_items,   through: :active_offerings,
                             class_name: "Item",
                             source: :item

  def self.mutate(possessions, current_user)
    json = []

    # events = possessions.map(&:attributes)
    # events = events.map { |p| p.merge(:user => User.find_by(id: p[:user_id])) }

    possessions.each do |possession|
      loc_string_1 = Possession.location_string(possession.latitude_1, possession.longitude_1)
      loc_string_2 = Possession.location_string(possession.latitude_2, possession.longitude_2)

      hash = {
        # **possession,
        id: possession.id,
        created_at: possession.created_at,
        updated_at: possession.updated_at,
        message: possession.message,
        latitude_1: possession.latitude_1,
        latitude_2: possession.latitude_2,
        longitude_1: possession.longitude_1,
        longitude_2: possession.longitude_2,
        active: possession.active,
        user: possession.user,
        location_1: loc_string_1,
        location_2: loc_string_2,
        is_mine: current_user.id == possession.user_id,
      }
      json << hash
    end
    json
  end

  def get_location_string
    string = ""
    loc = Geocoder.search("#{self.latitude},#{self.longitude}").first
    if loc
      string = "#{loc.city}, #{loc.state_code}"
    end
    string
  end
end
