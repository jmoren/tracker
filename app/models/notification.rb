class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :activity
  
  scope :readed, where(:readed => true)
  scope :unreaded, where(:readed => false)
end
