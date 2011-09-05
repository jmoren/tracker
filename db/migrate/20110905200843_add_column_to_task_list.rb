class AddColumnToTaskList < ActiveRecord::Migration
  def self.up
    add_column :task_lists, :status, :string
    add_column :task_lists, :comments, :text
  end

  def self.down
    remove_column :task_lists, :comments
    remove_column :task_lists, :status
  end
end
