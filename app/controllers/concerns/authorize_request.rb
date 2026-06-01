module AuthorizeRequest
  extend ActiveSupport::Concern

  included do
    before_action :authorize_request
  end

  private

  def authorize_request
    auth_header =
      request.headers["Authorization"]

    return unauthorized! unless auth_header

    token =
      auth_header.split(" ").last

    decoded =
      JsonWebToken.decode(token)

    return unauthorized! unless decoded

    @current_user =
      User.find_by(id: decoded[:user_id])

    return unauthorized! unless @current_user
  end

  def unauthorized!
    render json: {
      error: "Unauthorized"
    }, status: :unauthorized
  end
end
