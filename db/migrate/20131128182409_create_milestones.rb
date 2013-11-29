class CreateMilestones < ActiveRecord::Migration
  def change
    create_table :milestones do |t|
      t.belongs_to :project, index: true
      t.string :title

      t.timestamps
    end

    add_column :tasks, :milestone_id, :integer
  end
end
