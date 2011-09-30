class CreateNotifications < ActiveRecord::Migration
  def self.up
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :activity_id
      t.boolean :readed, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :notifications
  end
end
