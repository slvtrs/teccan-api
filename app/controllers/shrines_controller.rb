class ShrinesController < ApplicationController
  include ItemHelper
  
  def index
    shrines = Shrine.all

    loc = [params[:latitude].to_f, params[:longitude].to_f]
    nearest_shrine = nil
    distance_to_nearest_shrine = 6371000
    shrines.each do |shrine|
      shrine_loc = [shrine.latitude.to_f, shrine.longitude.to_f]
      dis = distance(loc, shrine_loc)
      if dis < distance_to_nearest_shrine
        nearest_shrine = shrine
        distance_to_nearest_shrine = dis
      end
    end

    render json: {
      success: true,
      shrines: shrines,
      distanceToNearestShrine: distance_to_nearest_shrine,
      nearestShrine: nearest_shrine,
    }
  end

  def show
    shrine = Shrine.find_by(id: params[:id])
    if shrine
      render json: {
        success: true,
        shrine: shrine,
        items: shrine.active_items,
      }
    else
      render json: {error: true, message: 'shrine not found'}
    end
  end

  def create
    item_id = params[:offering][:id]
    possession = current_user.possessions.find_by(item_id: item_id)
    possession.active = false

    shrine = current_user.shrines.build(shrine_params)

    if shrine.save
      possession.save
      offering = shrine.offerings.build(item_id: item_id, possession_id: possession.id)
      offering.save
      render json: {success: true, shrine: shrine}
    else
      render json: {error: true, message: 'something went wrong'}
    end
  end

  def update
    possession = Possession.find_by(id: params[:id])
    possession.message = params[:message]
    if possession.save
      possession = Possession.mutate([possession], current_user)[0]
      render json: { success: true, possession: possession }
    else
      render json: { error: true, message: 'failed to save' }
    end
  end

  private
  def shrine_params
    params.require(:shrine).permit(:latitude, :longitude, :title, :image, :description, :offering)
  end

end
