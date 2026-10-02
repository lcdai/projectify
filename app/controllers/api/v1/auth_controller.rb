module Api
  module V1
    class AuthController < BaseController
      before_action :authenticate_user!, only: [:me]

      def register
        user = User.new(user_params)

        if user.save
          render json: {
            user: user_payload(user),
            token: jwt_token(user)
          }, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def login
        user = User.find_by(email: params[:email])

        if user&.authenticate(params[:password])
          render json: {
            user: user_payload(user),
            token: jwt_token(user)
          }
        else
          render json: { errors: ["Invalid email or password"] }, status: :unauthorized
        end
      end

      def me
        render json: { user: user_payload(current_user) }
      end

      private

      def user_params
        params.permit(:name, :email, :password)
      end

      def user_payload(user)
        {
          id: user.id,
          name: user.name,
          email: user.email
        }
      end
    end
  end
end
