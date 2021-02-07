class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :api_key, :first,
             :last, :profile_type, :affiliation, :is_subscribed,
             :profile_image_path, :favorites

  def profile_image_path
    object.profile_image_path if object.profile_image.attached?
  end

end
