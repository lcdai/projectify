module Api
  module V1
    class BaseController < ApplicationController
      skip_forgery_protection

      private

      def current_user
        return @current_user if defined?(@current_user)

        header = request.headers["Authorization"]
        token = header&.split(" ")&.last

        return nil unless token

        decoded = JWT.decode(
          token,
          Rails.application.credentials.secret_key_base,
          true,
          algorithm: "HS256"
        )

        @current_user = User.find_by(id: decoded.first["user_id"])
      rescue JWT::DecodeError
        @current_user = nil
      end

      def authenticate_user!
        render json: { error: "Unauthorized" }, status: :unauthorized unless current_user
      end

      def jwt_token(user)
        payload = {
          user_id: user.id,
          exp: 7.days.from_now.to_i
        }

        JWT.encode(payload, Rails.application.credentials.secret_key_base, "HS256")
      end
    end
  end
end
