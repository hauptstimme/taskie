class AddDueDateToMilestones < ActiveRecord::Migration
  def change
    add_column :milestones, :due_date, :date
  end
end
