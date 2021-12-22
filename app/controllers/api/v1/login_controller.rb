module Api
  module V1
    class LoginController < ApplicationController
      api :POST, '/login',"Login user"
      formats ['json']
      returns code: 200, desc: 'OK'
      error 401, 'Unauthorized'
      param :username, String, desc: "username of the requested username", required: true
      param :password, String, desc: "password of the requested rpassword", required: true
      description <<-EOS
        == Description
          Create token for an user
        EOS
      def create
        @user = User.find_by(username: login_params[:username])

        if @user && @user.authenticate(login_params[:password])

          token = encode_token(@user)
          render json: { token: token }
        else
          render json: {error: "Invalid username or password"}, status: :unauthorized
        end
      end

      private

      def encode_token(user)
        Services::JsonWebToken.encode(user)
      end

      def login_params
        params
          .require(:login)
          .permit(
            :username,
            :password
          )
      end
    end
  end
end
