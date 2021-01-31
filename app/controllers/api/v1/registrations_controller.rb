module Api
  module V1
    class RegistrationsController < Api::ApiController

      skip_before_action :authenticate_api_user!

      def create
        user = User.new user_params
        if user.save
          success_response serialized_object user, serializer: UserSerializer
        else
          error_response user.errors.full_messages, status: :ok
        end
      end

      private

      def user_params
        params.require(:user).permit(
          :email,
          :password,
          supervisor_attributes: [
            :first,
            :last
          ]
        )
      end

    end
  end
end