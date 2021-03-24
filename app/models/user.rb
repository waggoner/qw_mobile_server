require 'csv'

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :validatable, :trackable

  has_secure_token :api_key

  has_one_attached :profile_image

  validates_presence_of :email, on: :create

  class << self
    def to_csv
      attr = column_names.reject { |col| csv_exclude.include? col }
      CSV.generate(headers: true) do |csv|
        csv << attr
        all.each do |user|
          csv << attr.map { |a| user.send(a) }
        end
      end
    end

    def csv_exclude
      %w[created_at updated_at encrypted_password reset_password_sent_at
         reset_password_token sign_in_count current_sign_in_at last_sign_in_at current_sign_in_ip
          last_sign_in_ip api_key receipt_verification]
    end
  end

  def profile_image_path
    Rails.application.routes.url_helpers.rails_blob_path(profile_image, only_path: true)
  end
end
