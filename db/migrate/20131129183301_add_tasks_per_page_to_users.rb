class AddTasksPerPageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :tasks_per_page, :integer
  end
end
