class ItemsController < ApplicationController
  include  ItemHelper

  def harvest
    dis = nil
    if params[:latitude] && params[:longitude]
      loc = [params[:latitude].to_f, params[:longitude].to_f]
      salem = [42.521493, -70.898882]
      dis = distance(loc, salem)
      dis = (dis / 1609.34).round(2)
    end

    items = [
      {title: 'Gem of Ruby', id:1},
      {title: 'Cursive Java', id:2},
      {title: 'Eggs of Python', id:5},
      {title: 'Shadow of Dom', id:6},
      {title: 'Compiling Natives', id:7},
    ]

    render json: {
      success: true,
      harvest: items,
      distance_from_salem: dis
    }
  end

  def inventory
    items = [
      {title: 'Raven Cache', id:3},
      {title: 'Toad Artifact', id:4},
    ]

    render json: {
      success: true,
      inventory: items,
    }
  end

  private
  def harvest_params
    # params.require(:user).permit(:status, :in_onward, :paywall, :name, :company, :email, :tier, :paused)
  end
end
