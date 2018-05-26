class PossessionsController < ApplicationController
  
  def index
    user = current_user || User.find_by(id: params[:user_id])
    puts 'index--------------'
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
    lat = params[:coords][:latitude]
    lon = params[:coords][:longitude]
    
    if lat.blank? || lon.blank?
      render json: {error: true, message: 'missing location info'}
      return
    end

    bounty = current_user.possessions.build(
      item_id: params[:bounty][:id], 
      latitude_1: lat, 
      longitude_1: lon,
    )
    # bounty.item.update_coords([nil,nil])

    offering = current_user.active_possessions.find_by(item_id: params[:offering][:id])
    offering.item.update_coords(lat, lon)

    offering.latitude_2 = lat
    offering.longitude_2 = lon
    offering.message = params[:message]
    offering.active = false

    if bounty && offering
      if bounty.save
        puts bounty.inspect
        # bounty.item.save
        offering.item.save

        if offering.save
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
    params.require(:possession).permit(:item_id, :message)
  end

  def item_params
    params.require(:item).permit(:id, :message)
  end

end
