class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.integer :task_list_id
      t.integer :project_id
      t.text :description
      t.string :status
      t.integer :user_id
      t.string :priority
      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end
