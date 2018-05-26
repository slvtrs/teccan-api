class ItemsController < ApplicationController
  include ItemHelper

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
      dis = distance(loc, salem)
      dis = (dis / 1609.34).round(2)
    end
    render json: {
      success: true,
      distance_from_salem: dis
    }
  end

  private
  def harvest_params
    # params.require(:user).permit(:status, :in_onward, :paywall, :name, :company, :email, :tier, :paused)
  end
end
