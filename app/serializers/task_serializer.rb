class TaskSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :comments
  embed :ids
end
