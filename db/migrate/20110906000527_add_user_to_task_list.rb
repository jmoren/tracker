class AddUserToTaskList < ActiveRecord::Migration
  def self.up
    add_column :task_lists, :user_id, :integer
  end

  def self.down
    remove_column :task_lists, :user_id
  end
end
