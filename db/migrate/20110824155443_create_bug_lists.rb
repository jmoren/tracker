class CreateBugLists < ActiveRecord::Migration
  def self.up
    create_table :bug_lists do |t|
      t.integer :project_id
      t.string :title
      t.timestamps
    end
  end

  def self.down
    drop_table :bug_lists
  end
end
