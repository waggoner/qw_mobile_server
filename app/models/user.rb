class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :validatable, :trackable

  has_secure_token :api_key

  validates_presence_of :email, on: :create
end
