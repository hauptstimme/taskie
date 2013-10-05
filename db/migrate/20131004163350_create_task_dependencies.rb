class CreateTaskDependencies < ActiveRecord::Migration
  def change
    create_table :task_dependencies do |t|
      t.integer :dependent_id
      t.integer :dependency_id
    end
  end
end
