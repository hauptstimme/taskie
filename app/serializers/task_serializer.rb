class TaskSerializer < ActiveModel::Serializer
  attributes :id, :name, :details, :priority
  has_one :creator, root: :users
  has_one :assignee, root: :users
  has_one :milestone

  embed :ids, include: true
end
