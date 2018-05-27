class Possession < ApplicationRecord
  belongs_to :user
  belongs_to :item
  
  validates_associated :item
  # validates :latitude, :longitude, presence: true
  
  scope :active,   -> { where(active: true)  }
  scope :inactive, -> { where(active: false) }

  def update_coords (lat, lon)
    self.latitude = lat
    self.longitude = lon
  end

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

  def self.location_string(lat, lon)
    string = ""
    loc = Geocoder.search("#{lat},#{lon}").first
    if loc
      string = "#{loc.city}, #{loc.state_code}"
    end
    string
  end
end
