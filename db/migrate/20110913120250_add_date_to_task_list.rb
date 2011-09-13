class AddDateToTaskList < ActiveRecord::Migration
  def self.up
    add_column :task_lists, :end_date, :date
  end

  def self.down
    remove_column :task_lists, :end_date
  end
end
