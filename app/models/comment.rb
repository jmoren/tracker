class Comment < ActiveRecord::Base
  belongs_to :task
  belongs_to :user
  has_many :activities, :as => :target
  attr_accessible :task_id, :user_id, :body
end
