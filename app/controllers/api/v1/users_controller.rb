module Api
  module V1
    class UsersController < Api::ApiController

      def update
        if @api_user.update(user_params)
          success_response serialized_object @api_user, serializer: UserSerializer
        else
          error_response @api_user.errors.full_messages, status: :ok
        end
      end

      private

      def user_params
        params.require(:user).permit(
          :first,
          :last,
          :profile_type,
          :affiliation,
          :profile_image
        )
      end
    end
  end
end


