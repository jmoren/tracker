class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.integer :user_id
      t.integer :project_id
      t.integer :target_id
      t.string :target_type
      t.string :activity_type
      t.string :action

      t.timestamps
    end
  end

  def self.down
    drop_table :activities
  end
end
