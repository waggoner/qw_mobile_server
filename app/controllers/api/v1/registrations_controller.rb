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

      def reset
        user = User.find_by(email: user_params[:email])
        if user
          user.send_reset_password_instructions
          success_response
        else
          error_response [], status: :ok
        end
      end

      private

      def user_params
        params.require(:user).permit(
          :email,
          :password,
          :first,
          :last,
          :profile_type,
          :affiliation,
          :terms_accepted
        )
      end

    end
  end
end