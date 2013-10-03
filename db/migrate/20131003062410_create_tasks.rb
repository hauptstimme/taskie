class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :assignee_id
      t.string :name
      t.text :details
      t.boolean :status, default: false

      t.timestamps
    end
  end
end
