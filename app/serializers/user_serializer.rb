class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :time_zone
end
