class MilestoneSerializer < ActiveModel::Serializer
  attributes :id, :tasks, :title
  has_one :project
end
