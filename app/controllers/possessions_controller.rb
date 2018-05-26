class PossessionsController < ApplicationController
  
  def index
    user = current_user || User.find_by(id: params[:user_id])
    if user
      items = user.active_items
      render json: {
        success: true,
        items: items,
      }
    else
      render json: {error: true, message: 'missing user'}
    end
  end

  def trade
    coords = [possession_params.latitude, possession_params.longitude]

    bounty = current_user.possessions.build(possession_params)
    # bounty.item.update_coords(coords)
    # bounty.item.update_coords([nil,nil])

    offering = current_user.possessions.find_by(id: params[:offering_id])
    offering.item.update_coords(coords)

    if bounty && offering
      if bounty.save
        bounty.item.save
        offering.item.save

        if offering.destroy
          render json: {success: true, item: bounty.item}
        else
          render json: {error: true, message: 'could not save'}
        end
      end
    end
  end

  # def create
  #   possession = current_user.possessions.build(possession_params)
  #   possession.active = true
  #   if possession.save
  #     render json: {success: true, possession: possession}
  #   else
  #     render json: {error: true, message: 'could not save'}
  #   end
  # end

  # def destroy
  #   possession = Possession.find_by(id: params[:id])
  #   if possession
  #     if possession.destroy
  #       render json: {status: 200}
  #     else
  #       render json: {status: 500}
  #     end
  #   else
  #     render json: {status: 404}
  #   end
  # end

  private
  def possession_params
    params.require(:possession).permit(:item_id, :message, :latitude, :longitude)
  end

end
