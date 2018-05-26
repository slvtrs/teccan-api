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

  def self.add_user(possessions)
    json = []

    # events = possessions.map(&:attributes)
    # events = events.map { |p| p.merge(:user => User.find_by(id: p[:user_id])) }

    possessions.each do |possession|
      user = User.find_by(id: possession.user_id)
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
        user: possession.user,
      }
      json << hash
    end
    json
  end
end
