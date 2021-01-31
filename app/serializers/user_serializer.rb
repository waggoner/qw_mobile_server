class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :api_key, :profile_type, :affiliation
end
