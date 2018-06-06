class ItemsController < ApplicationController

  def show
    item = Item.find_by(id: params[:id])
    # possessions = Possession.where(item_id: item.id, active: false).order(updated_at: :desc)
    possessions = Possession.where(item_id: item.id).order(updated_at: :desc)
    timeline = Possession.mutate(possessions, current_user)

    # puts item.inspect
    # puts timeline.inspect
    render json: {
      success: true,
      item: item,
      timeline: timeline,
    }
  end

  def create
    item = current_user.items.build(item_params)
    if item.save
      possession = current_user.possessions.build(item_id: item.id)
      possession.save
      render json: {success: true, item: item}
    else
      render json: {error: true, message: 'something went wrong'}
    end
  end

  def nearby
    items = Item.get_all_unpossessed
    render json: {
      success: true,
      items: items,
    }
  end

  def distance
    dis = nil
    if params[:latitude] && params[:longitude]
      loc = [params[:latitude].to_f, params[:longitude].to_f]
      salem = [42.521493, -70.898882]
      dis = Distance.meters(loc, salem)
      dis = (dis / 1609.34).round(2)
    end
    render json: {
      success: true,
      distance_from_salem: dis
    }
  end

  private
  def item_params
    params.require(:item).permit(:title, :description, :image)
  end
end
