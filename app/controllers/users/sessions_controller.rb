# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  skip_before_action :authenticate_user_from_token!
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    if user = User.find_for_authentication(email: sign_in_params[:email])
      if user.valid_password?(sign_in_params[:password])
        sign_in :user, user
        auth_token = user.init_device
        render json: {success: true, token: auth_token}
        return
      else
        render json: {error: true, message:'invalid password'}, status: :unprocessable_entity
      end
    else
      render json: {error: true, message:'invalid email address'}, status: :unprocessable_entity
    end
  end

  def update_device
    message = ''
    auth_token = params[:token]
    if auth_token.include?(':')
      user_id = auth_token.split(':').first
      user = User.find_by(id: user_id)
      token = auth_token.split(':').last
      if user
        device = user.devices.find_by(token: token)
        device_id = params[:device_id]
        if device_id
          device.update_attributes!(device_id: device_id)
          message += "device_id udpated: #{device_id}. "
        end
        device_type = params[:device_type]
        if device_type
          device.update_attributes!(device_type: device_type)
          message += "device_type udpated: #{device_type}. "
        end
      end
    end
    render json: {message: message}
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end
  def log_out
    message = ''
    auth_token = params[:token]
    if auth_token.include?(':')
      user_id = auth_token.split(':').first
      user = User.where(id: user_id).first
      token = auth_token.split(':').last
      if user
        device = user.devices.find_by(token: token)
        if device && Devise.secure_compare(device.token, token)
          device.delete
          message = 'access revoked'
          sign_out(user)
        end
      end
    end
    render json: {message: message}
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
