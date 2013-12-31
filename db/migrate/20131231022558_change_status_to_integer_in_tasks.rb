class ChangeStatusToIntegerInTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :integer_status, :integer, default: 0
    Task.find_each do |t|
      t.update_column :integer_status, (t.status ? 1 : 0)
    end
    remove_column :tasks, :status
    rename_column :tasks, :integer_status, :status
  end
end
