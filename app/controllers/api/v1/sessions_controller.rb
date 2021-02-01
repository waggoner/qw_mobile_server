module Api
  module V1
    class SessionsController < Api::ApiController

      skip_before_action :authenticate_api_user!

      def create
        @user = User.find_by_email(user_params[:email].downcase)
        if @user
          handle_user_response
        else
          error_response ["Account not found"], status: :ok
        end
      end

      private

      def handle_user_response
        if @user.valid_password?(user_params[:password])
          success_response serialized_object @user, serializer: UserSerializer
        else
          error_response ["Invalid password"], status: :ok
        end
      end

      def user_params
        params.require(:user).permit(
            :email,
            :password
        )
      end

    end
  end
end
