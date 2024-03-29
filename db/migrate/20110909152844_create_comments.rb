class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :task_id
      t.text :body
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
