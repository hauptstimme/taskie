class AddAutoFollowTasksToUsers < ActiveRecord::Migration
  def up
    add_column :users, :auto_follow_tasks, :boolean, default: true
    User.update_all auto_follow_tasks: true
  end

  def down
    remove_column :users, :auto_follow_tasks
  end
end
