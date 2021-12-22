class ApplicationController < ActionController::API

  rescue_from JWT::DecodeError do |exception|
    render json: { errors: exception.message }, status: :forbidden
  end

  private

  def authorize_request!
    if request.headers['Authorization'] != nil
      bearer, @token = request.headers['Authorization'].split(' ')
      if bearer === "Bearer"
        find_user
      else
        render json: { error: 'bad request' }, status: :bad_request
      end
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  def find_user
    @user = Services::JsonWebToken.decode(@token)
  end
end
