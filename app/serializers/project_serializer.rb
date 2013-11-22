class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :active_tasks
  has_one :owner, root: :users
  has_many :users

  embed :ids, include: true

  def active_tasks
    object.tasks.active.count
  end
end
