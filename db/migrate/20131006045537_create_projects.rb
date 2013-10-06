class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text :details

      t.timestamps
    end

    add_column :tasks, :project_id, :integer
  end
end
