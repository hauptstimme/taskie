class TaskDependency < ActiveRecord::Base
  belongs_to :dependent, class_name: "Task"
  belongs_to :dependency, class_name: "Task"
end
