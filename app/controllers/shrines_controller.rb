class ShrinesController < ApplicationController

  def index
    loc = [params[:latitude].to_f, params[:longitude].to_f]
    shrines = Shrine.mutate(Shrine.all, current_user, loc)
    nearest_shrine = Shrine.nearest(shrines)

    render json: {
      success: true,
      shrines: shrines,
      nearestShrine: nearest_shrine,
    }
  end

  def show
    shrine = Shrine.find_by(id: params[:id])
    # loc = [params[:latitude].to_f, params[:longitude].to_f]
    # shrine = Shrine.mutate([shrine], current_user, loc)[0]
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
    item = JSON.parse(params[:offering])
    item_id = item['id']
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
    params.require(:shrine).permit(:latitude, :longitude, :title, :image, :description)
  end

end
