class ApplicationController < ActionController::API
  # protect_from_forgery with: :null_session
  before_action :authenticate_user_from_token!
  respond_to :json

  def authenticate_user_from_token!
    # auth_token = request.headers['Authorization']
    if auth_token = request.headers['Authorization']
      authenticate_with_auth_token(auth_token)
    else
      authentication_error
    end
  end

  private

  def authenticate_with_auth_token(auth_token)
    unless auth_token.include?(':')
      authentication_error
      return
    end

    user_id = auth_token.split(':').first
    user = User.where(id: user_id).first
    token = auth_token.split(':').last

    if user
      device = user.devices.where(token: token).first
      if device && Devise.secure_compare(device.token, token)
          device.touch
          sign_in user, store: false
      else
        authentication_error('Please try signing in again')
      end
    else
      authentication_error
    end
  end

  def authentication_error(message = nil)
    render json: {error: message}, status: 401
  end

end
