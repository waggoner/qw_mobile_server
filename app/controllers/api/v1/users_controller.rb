module Api
  module V1
    class UsersController < Api::ApiController

      def show
        success_response serialized_object @api_user, serializer: UserSerializer
      end

      def update
        if @api_user.update(user_params)
          success_response serialized_object @api_user, serializer: UserSerializer
        else
          error_response @api_user.errors.full_messages, status: :ok
        end
      end

      def add_favorite
        case
        when params[:wrestler]
          wrestlers = @api_user.favorites['wrestlers'] || []
          wrestlers << params[:wrestler]
          @api_user.favorites['wrestlers'] = wrestlers.uniq
          @api_user.save
        when params[:post]
          posts = @api_user.favorites['posts'] || []
          posts << params[:post]
          @api_user.favorites['posts'] = posts.uniq
          @api_user.save
        end
        success_response
      end

      def remove_favorite
        case
        when params[:wrestler]
          wrestlers = @api_user.favorites['wrestlers'] || []
          updated = wrestlers.reject { |w| w == params[:wrestler] }
          @api_user.favorites['wrestlers'] = updated
          @api_user.save
        when params[:post]
          posts = @api_user.favorites['posts'] || []
          updated = posts.reject { |p| p == params[:post] }
          @api_user.favorites['posts'] = updated
          @api_user.save
        end
        success_response
      end

      private

      def user_params
        params.require(:user).permit(
          :first,
          :last,
          :profile_type,
          :affiliation,
          :profile_image,
          :is_subscribed,
          :receipt_verification
        )
      end
    end
  end
end


