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
      # user = User.find_by(id: possession.user_id)
      loc_1 = Geocoder.search("#{possession.latitude_1},#{possession.longitude_1}").first
      loc_2 = Geocoder.search("#{possession.latitude_2},#{possession.longitude_2}").first
      city_1 = loc_1 ? loc_1.city : ''
      city_2 = loc_2 ? loc_2.city : ''

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
        city_1: city_1,
        city_2: city_2,
        is_mine: current_user.id == possession.user_id,
      }
      json << hash
    end
    json
  end
end
