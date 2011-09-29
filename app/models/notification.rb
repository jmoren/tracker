class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :activity
  
  scope :readed, where(:readed => true)
  scope :unreaded, where(:readed => false || nil)
  scope :recents, where('created_at >= ? ', (Time.now - 2.days) )
end
