class Offering < ApplicationRecord
  belongs_to :shrine
  belongs_to :item
  validates_associated :item

  scope :active,   -> { where(active: true)  }
  scope :inactive, -> { where(active: false) }

  def location
    if self.shrine
      [self.shrine.latitude, slef.shrine.longitude]
    end
  end

  def message
    self.possession.message
  end

  def self.mutate(offerings, current_user)
    json = []

    # events = possessions.map(&:attributes)
    # events = events.map { |p| p.merge(:user => User.find_by(id: p[:user_id])) }

    offerings.each do |o|
      hash = {
        id: o.id,
        created_at: o.created_at,
        updated_at: o.updated_at,
        message: o.message,
        latitude_1: o.latitude_1,
        latitude_2: o.latitude_2,
        longitude_1: o.longitude_1,
        longitude_2: o.longitude_2,
        active: o.active,
        user: o.user,
        location: o.shrine.get_location_string,
        # location_1: loc_string_1,
        # location_2: loc_string_2,
        is_mine: current_user.id == o.user_id,
      }
      json << hash
    end
    json
  end

end
