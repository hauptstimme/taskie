class CreateTagsTasks < ActiveRecord::Migration
  def up
    create_table :tags_tasks, id: false do |t|
      t.integer :tag_id
      t.integer :task_id
    end

    add_index :tags_tasks, :tag_id
    add_index :tags_tasks, :task_id
    add_index :tags_tasks, [:task_id, :tag_id], unique: true
  end

  def down
    drop_table :tags_tasks
  end
end
