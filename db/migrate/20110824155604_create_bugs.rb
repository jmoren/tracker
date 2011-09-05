class CreateBugs < ActiveRecord::Migration
  def self.up
    create_table :bugs do |t|
      t.integer :bug_list_id
      t.integer :project_id
      t.text :description
      t.string :status
      t.integer :user_id
      t.integer :owner
      t.timestamps
    end
  end

  def self.down
    drop_table :bugs
  end
end
