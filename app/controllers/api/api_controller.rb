module Api
  class ApiController < ActionController::API

    include ActionController::HttpAuthentication::Token::ControllerMethods
    include Responses
    include ApiSessions

    before_action :authenticate_api_request!
    before_action :authenticate_api_user!

    serialization_scope :api_user

    rescue_from Exception do |exception|
      render json: [exception.message], status: :bad_request
    end

  end
end