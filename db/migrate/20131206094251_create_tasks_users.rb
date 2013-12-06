class CreateTasksUsers < ActiveRecord::Migration
  def up
    create_table :tasks_users, id: false do |t|
      t.integer :task_id
      t.integer :user_id
    end

    add_index :tasks_users, :task_id
    add_index :tasks_users, [:task_id, :user_id], unique: true

    Task.all.each do |t|
      t.follower_ids = [t.creator_id, t.assignee_id].compact.uniq
      puts "##{t.id} followers updated"
    end
  end

  def down
    drop_table :tasks_users
  end
end
