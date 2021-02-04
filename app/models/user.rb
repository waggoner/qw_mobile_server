class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :validatable, :trackable

  has_secure_token :api_key

  has_one_attached :profile_image

  validates_presence_of :email, on: :create

  def profile_image_path
    Rails.application.routes.url_helpers.rails_blob_path(profile_image, only_path: true)
  end
end
